  <!-- Start offcanvas =================================== -->
  <button class="btn icon lg offcanvas-btn" type="button" data-bs-toggle="offcanvas" data-bs-target="#companyOffcanvas"
    aria-controls="companyOffcanvas"><i class="bi bi-arrow-bar-left"></i></button>

  <div class="offcanvas offcanvas-end" tabindex="-1" id="companyOffcanvas" aria-labelledby="companyOffcanvasLabel">
    <div class="offcanvas-header">
      <h5 class="offcanvas-title" id="companyOffcanvasLabel">companies</h5>
      <button type="button" class="btn icon" data-bs-dismiss="offcanvas" aria-label="Close"> <i
          class="bi bi-x-lg"></i></button>
    </div>
    <div class="offcanvas-body">
      <ul class="companies">
        <li class="company-item">
          <a href="#" class="active">
            <img src="{{Vite::asset('resources/template/assets/images/logo/utkorshoIT.png')}}" alt="Medixam">
            <p>Utkorsho IT</p>
          </a>
        </li>
        <li class="company-item">
          <a href="#">
            <img src="{{Vite::asset('resources/template/assets/images/logo/oporajito.png')}}" alt="Medixam">
            <p>Oporajito</p>
          </a>
        </li>
        <li class="company-item">
          <a href="#">
            <img src="{{Vite::asset('resources/template/assets/images/logo/medixam.jpg')}}" alt="Medixam">
            <p>Medexam</p>
          </a>
        </li>
      </ul>

    </div>
    <div class="offcanvas-footer p-3">
      <div class="d-grid">
        <a href="index.html" class="btn btn-secondary rounded mt-0">Show all</a>
      </div>
    </div>
  </div>
  <!-- End offcanvas =================================== -->
