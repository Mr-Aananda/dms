<div class="modal fade" id="brandCreateModal" tabindex="-1" aria-labelledby="brandModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Add New Brand</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="{{ route('brand.store') }}" method="POST">
            @csrf
            <div class="row g-3 mb-2">
                <div class="col-md-12">
                <x-form.label name="Name" for="name" required/>
                <x-form.input type="text" id="name" name="name" placeholder="Enter brand name" required autofocus/>
                </div>
            </div>
            <div class="row g-3 mb-2">
                <div class="col-md-12">
                <x-form.label name="Description" for="description"/>
                <x-form.input type="textarea" id="description" name="description" placeholder="Optional"/>
                </div>
            </div>
            <!-- Move the submit button inside the form -->
            <div class="row mt-3">
                <div class="col-12 text-end">
                    <x-form.reset/>
                    <x-form.save name="Add Brand"/>
                </div>
            </div>
        </form>
      </div>
    </div>
  </div>
</div>
