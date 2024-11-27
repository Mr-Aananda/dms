<div class="modal fade" id="investWithdrawCreateModal" tabindex="-1" aria-labelledby="investWithdrawModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Withdraw Investment</h5>
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
                    <x-form.label name="Invest Amount" for="amount" required/>
                    <x-form.input type="number" id="amount" value="{{ $invest->amount }}" name="amount" required/>
                </div>
            </div>
            <div class="row g-3 mb-2">
                <div class="col-md-12">
                    <x-form.label name="Profit Change" for="profit"/>
                    <div class="input-group">
                        <x-form.input type="number" id="profit" name="profit" value="{{ old('profit') ?? abs($invest->profit) }}" step="any" min="0" placeholder="0.00"/>
                        <div class="input-group-append">
                            <select name="profit_type" class="form-select px-5 fw-bold">
                                <option value="flat" {{$invest->profit_type == 'flat' ? 'selected':''}}>Flat</option>
                                <option value="percentage" {{$invest->profit_type == 'percentage' ? 'selected':''}}>Percentage</option>
                            </select>
                        </div>
                    </div>
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
                <input type="hidden" name="type" value="invest_withdraw">
                 <input type="hidden" name="invest_id" value="{{ $invest->id }}">
                 <input type="hidden" name="branch_id" value="{{ $invest->branch_id }}">
            </div>
            <!-- Move the submit button inside the form -->
            <div class="row mt-3">
                <div class="col-12 text-end">
                    <x-form.save name="Withdraw Invest"/>
                </div>
            </div>
        </form>
      </div>
    </div>
  </div>
</div>
