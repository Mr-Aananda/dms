<div class="modal fade" id="profitWithdrawCreateModal" tabindex="-1" aria-labelledby="profitWithdrawModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Add New Withdraw</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="{{ route('invest-withdraw.store') }}" method="POST">
            @csrf
            <div class="row g-3 mb-2">
                <div class="col-md-12">
                <x-form.label name="Date" for="date" required/>
                <x-form.input type="date" id="date" value="{{ old('date') ?? date('Y-m-d') }}" name="date" required autofocus/>
                </div>
            </div>
            <div class="row g-3 mb-2">
                <div class="col-md-12">
                <x-form.label name="Profit Amount" for="amount" required/>
                <x-form.input type="number" id="amount" value="{{ $profit_amount }}" name="amount" required readonly/>
                </div>
            </div>
            <div class="row g-3 mb-2">
                <div class="col-md-12">
                    <payment-option-component
                        :errors="{{ $errors }}"
                    />
                </div>
            </div>
            <div class="row g-3 mb-2">
                <div class="col-md-12">
                <x-form.label name="Note" for="note"/>
                <x-form.input type="textarea" id="note" name="note" placeholder="Optional"/>
                </div>
            </div>

            <div>
                <input type="hidden" name="type" value="profit_withdraw">
                <input type="hidden" name="invest_id" value="{{ $invest->id }}">
                <input type="hidden" name="branch_id" value="{{ $invest->branch_id }}">
            </div>
            <!-- Move the submit button inside the form -->
            <div class="row mt-3">
                <div class="col-12 text-end">
                    <x-form.save name="Withdraw"/>
                </div>
            </div>
        </form>
      </div>
    </div>
  </div>
</div>
