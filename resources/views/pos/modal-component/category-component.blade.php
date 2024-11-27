<div class="modal fade" id="categoryCreateModal" tabindex="-1" aria-labelledby="categoryModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Add New Category/Subcategory</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
            <form action="{{ route('category.store') }}" method="POST">
                @csrf
                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Name" for="name" required/>
                        <x-form.input type="text" id="name" name="name" placeholder="Enter category or subcategory name" required autofocus/>
                    </div>
                </div>
                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Select Category" for="category"/>
                            <select name="parent_id" id="parent" class="form-select @error('parent_id') is-invalid @enderror">
                            <option value="" disabled selected>-- Select a Category --</option>
                            <x-form.category-select :categories="$categories" :level="0"
                                :selected="old('parent_id')"
                                :existing-category-id="$existingCategoryId"
                                />
                        </select>

                        @error('parent_id')
                            <div class="invalid-feedback">
                                {{ $message }}
                            </div>
                        @enderror
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Description" for="description"/>
                        <x-form.input type="textarea" id="description" name="description" placeholder="Optional"/>
                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-12 text-end">
                        <x-form.reset/>
                        <x-form.save name="New Category"/>
                    </div>
                </div>
            </form>
      </div>
    </div>
  </div>
</div>
