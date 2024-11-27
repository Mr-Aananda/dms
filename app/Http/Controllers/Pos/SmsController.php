<?php

namespace App\Http\Controllers\Pos;

use App\Helpers\SMS;
use App\Http\Controllers\Controller;
use App\Models\Party;
use App\Models\Sms as ModelsSms;
use App\Models\SmsTemplate;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class SmsController extends Controller
{
    private $paginate = 25;
    public $sender_id, $api_key;

    public function __construct()
    {
        $this->sender_id = env('SMS_SENDER_ID');
        $this->api_key = env('SMS_API_KEY');
    }


    public function report()
    {
        $allReports = ModelsSms::get();
        $smsReports_query = ModelsSms::query();

        // Initialize a variable to hold the total_sms count
        $totalSendSmsCount = 0;

        // Loop through each record and sum up the total_sms count
        foreach ($allReports as $report) {
            $totalSendSmsCount += $report->total_sms;
        }

        //search by date to date
        if (request()->search) {
            $start_date = date('Y-m-d', strtotime(request()->date_from));
            $end_date = date('Y-m-d', strtotime(request()->date_to));

            $smsReports_query->whereBetween('created_at', [$start_date . ' 00:00:00', $end_date . ' 23:59:00']);
        }
        $smsReports = $smsReports_query->paginate($this->paginate);
        $sms_balance = json_decode(SMS::smsCurrentBalance())->balance;
        $remaining_sms = intval($sms_balance / 0.25);

        return view('pos.sms.report', compact('smsReports', 'allReports', 'sms_balance', 'remaining_sms', 'totalSendSmsCount'));
    }

    public function groupSms(Request $request)
    {

        $customer_query = Party::query()->customer();
        $supplier_query = Party::query()->supplier();
        $user_query = User::query();
        $type = $request->get('type', 'all'); // default to 'all' if no type is selected


        if ($type == 'customer') {
            $datas = $customer_query
                ->select('parties.name', 'parties.phone', $customer_query->raw('"customer" as type'))
                ->paginate($this->getPerPage($request));
        } elseif ($type == 'supplier') {
            $datas = $supplier_query
                ->select('parties.name', 'parties.phone', $supplier_query->raw('"supplier" as type'))
                ->paginate($this->getPerPage($request));
        } elseif ($type == 'user') {
            $datas = $user_query
                ->select('users.name', 'users.phone', $user_query->raw('"user" as type'))
                ->paginate($this->getPerPage($request));
        } else {

            $datas = $customer_query
                ->select('parties.name', 'parties.phone', $customer_query->raw('"customer" as type'))
                ->unionAll(
                $supplier_query
                        ->select('parties.name', 'parties.phone', $supplier_query->raw('"supplier" as type'))
                )
                ->unionAll(
                $user_query
                        ->select('users.name', 'users.phone', $user_query->raw('"user" as type'))
                )
                ->paginate($this->getPerPage($request));
        }

        $sms_balance = json_decode(SMS::smsCurrentBalance())->balance;

        $remaining_sms = intval($sms_balance / 0.25);

        $templates = SmsTemplate::all();

        return view('pos.sms.group-sms', compact('datas', 'type', 'sms_balance', 'remaining_sms', 'templates'));
    }

    public function groupSmsSend(Request $request)
    {
        // return $request->all();
        // Validate request data
        $request->validate([
            'message' => 'required|string',
            'phones' => 'required|array',
            'phones.*' => 'string|size:11|starts_with:01'
        ]);

        // Compose SMS message
        $message = $request->message . " " . config('pos.regards');

        // Join phone numbers into a comma-separated string
        $phones = join(',', $request->phones);

        // Send SMS
        $response = SMS::groupSmsSend($this->sender_id, $this->api_key, $phones, $message);
        $responseDecode = json_decode($response);

        // Handle response
        if ($responseDecode) {
            $smsStatus = $responseDecode->response_code;
            $smsStatusMessage = $this->getSmsStatusMessage($smsStatus);

            if ($smsStatus == 202) {
                // Store SMS details if successful
                $this->storeSms($phones, $message, $request);
                return redirect()->route('sms.group-sms')->withSuccess($smsStatusMessage);
            } else {
                $errorMessage = $smsStatusMessage;
            }
        } else {
            $errorMessage = "Failed to send SMS. Please try again later.";
        }

        // Redirect back with error message
        return back()->withErrors($errorMessage)->withInput();
    }



    public function customSms()
    {
        $sms_balance = json_decode(SMS::smsCurrentBalance())->balance;

        $remaining_sms = intval($sms_balance / 0.25);

        $templates = SmsTemplate::all();

        return view('pos.sms.custom-sms', compact('sms_balance', 'remaining_sms', 'templates'));
    }

    public function customSmsSend(Request $request)
    {
        // Validate phone numbers
        $phones = explode(',', $request->phones); // Convert comma-separated string to array
        foreach ($phones as $phone) {
            if (!str_starts_with($phone, '01') || strlen($phone) != 11) {
                return redirect()->back()->withErrors('Mobile number must start with 01 and have 11 digits')->withInput();
            }
        }

        // Validate request data
        $request->validate([
            'message' => 'required|string',
            'phones' => 'required|string',
            'phones.*' => 'string|size:11|starts_with:01'
        ]);

        // Compose SMS message
        $message = $request->message . " " . config('pos.regards');

        // Send SMS
        $response = SMS::customSmsSend($this->sender_id, $this->api_key, $request->phones, $message);
        $responseDecode = json_decode($response);

        // Handle response
        if ($responseDecode) {
            $smsStatus = $responseDecode->response_code;
            $smsStatusMessage = $this->getSmsStatusMessage($smsStatus);

            if ($smsStatus == 202) {
                // Store SMS details if successful
                $this->storeSms($phones, $message, $request);
                return redirect()->route('sms.custom-sms')->withSuccess($smsStatusMessage);
            } else {
                $errorMessage = $smsStatusMessage;
            }
        } else {
            $errorMessage = "Failed to send SMS. Please try again later.";
        }

        // Redirect back with error message
        return back()->withErrors($errorMessage)->withInput();
    }



    //Store sms
    public function storeSms($phones, $message, $request)
    {
        // Convert $phones to an array if it's a comma-separated string
        $phonesArray = is_array($phones) ? $phones : explode(',', $phones);

        foreach ($phonesArray as $phone) {
            ModelsSms::create([
                'branch_id' => Auth::user()->branch_id,
                'user_id' => Auth::user()->id,
                'phone' => $phone,
                'message' => $message,
                'total_character' => $request->total_characters,
                'total_sms' => $request->total_messages,
                'status' => true,
            ]);
        }
    }


    //Get message from status code
    private function getSmsStatusMessage($smsStatus)
    {
        switch ($smsStatus) {
            case '202':
                return "SMS has been sent successfully.";
            case '1002':
                return "Sender id not correct/sender id is disabled.";
            case '1003':
                return "Please Required all fields/Contact Your System Administrator.";
            case '1005':
                return "Internal Error.";
            case '1006':
                return "Balance Validity Not Available.";
            case '1007':
                return "Balance Insufficient.";
            case '1011':
                return "User Id not found.";
            default:
                return "Failed to send SMS. Please try again later.";
        }
    }

    private function getPerPage(Request $request)
    {
        $perPage = request('perPage', 25);
        if ($perPage === 'all') {
            return PHP_INT_MAX;
        }
        return in_array($perPage, [25, 50, 100, 250]) ? $perPage : 25;
    }
}
