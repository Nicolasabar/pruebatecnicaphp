var formulario = document.getElementById('form-votacion');
var respuesta = document.getElementById('respuesta');


function validateLastName(){
  var lastNameInput = document.getElementsByName('last-name')[0];
  var fullName = lastNameInput.value.trim();
  if (fullName === ''){
    respuesta.innerHTML = `<div class="alert alert-danger" role="alert">
      El campo Nombre y Apellido es obligatorio
    </div>`;
    setTimeout(() => {
      respuesta.innerHTML = '';
    }, 1000);
    return false;
  } else if (fullName.indexOf(' ') === -1 || fullName.split(' ').length < 2) {
    respuesta.innerHTML = `<div class="alert alert-danger" role="alert">
      Debe ingresar nombre y apellido separados por un espacio
    </div>`;
    setTimeout(() => {
      respuesta.innerHTML = '';
    }, 1000);
    return false;
  }
  return true;
}


document.addEventListener('DOMContentLoaded', function() {
  getCandidato();
});

function getCandidato() {
  fetch('back.php', {
    method: 'GET'
  })
    .then(response => response.json())
    .then(data => {
      console.log(data);
      if (data.message === 'Nombres encontrados') {
        const nombres = data.data;
        const select = document.getElementById('candidatoSelect');
        
        nombres.forEach(nombre => {
          const option = document.createElement('option');
          option.value = nombre;
          option.textContent = nombre;
          select.appendChild(option);
        });
        
        console.log('Datos cargados correctamente');
      } else {
        console.log('No se encontraron nombres');
      }
    })
    .catch(error => {
      console.error('Hubo un error al obtener la tabla candidatos:', error);
    });
}


function getRegionComuna() {
  fetch('back.php', {
    method: 'GET'
  })
    .then(response => response.json())
    .then(data => {
      console.log(data);
      if (data.message === 'Datos obtenidos') {
        const dataByRegion = data.data;
        const regionSelect = document.querySelector('#regionSelect');
        const comunaSelect = document.querySelector('#comunaSelect');

        // Llenar el select de regiones
        for (const region in dataByRegion) {
          if (dataByRegion.hasOwnProperty(region)) {
            const option = document.createElement('option');
            option.value = region;
            option.textContent = region;
            regionSelect.appendChild(option);
          }
        }

        // Mostrar las comunas correspondientes a la región seleccionada
        regionSelect.addEventListener('change', () => {
          const selectedRegion = regionSelect.value;
          const comunas = dataByRegion[selectedRegion];

          // Limpiar el select de comunas
          comunaSelect.innerHTML = '';

          // Llenar el select de comunas
          comunas.forEach(comuna => {
            const option = document.createElement('option');
            option.value = comuna;
            option.textContent = comuna;
            comunaSelect.appendChild(option);
          });
        });

        console.log('Datos cargados correctamente');
      } else {
        console.log('No se encontraron datos');
      }
    })
    .catch(error => {
      console.error('Hubo un error al obtener los datos:', error);
    });
}

// Ejecutar la función al cargar la página
getRegionComuna();



function validateAlias() {
  const aliasInput = document.querySelector('input[name="alias"]');
  const aliasValue = aliasInput.value.trim();

  // Verificar que el alias tenga al menos 5 caracteres
  if (aliasValue.length < 5) {
    respuesta.innerHTML = `<div class="alert alert-danger" role="alert">
    El alias debe tener al menos 5 caracteres entre letras y numeros
    </div>`;
    setTimeout(() => {
      respuesta.innerHTML = '';
    }, 1000);
    return false;
  }

  // Verificar que el alias contenga letras y números
  const regex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+$/;
  if (!regex.test(aliasValue)) {
    respuesta.innerHTML = `<div class="alert alert-danger" role="alert">
    El alias debe contener letras y numeros
    </div>`;
    setTimeout(() => {
      respuesta.innerHTML = '';
    }, 1000);
    return false;
  }

  // Si pasa todas las validaciones, retornar true
  return true;
}


// Validar rut formato chile. 
function validateRut(){
  var rutInput = document.getElementsByName('rut')[0];
  var rut = rutInput.value.trim();
  if (rut === ''){
    respuesta.innerHTML = `<div class="alert alert-danger" role="alert">
      El campo Rut es obligatorio
    </div>`;
    return false;
  }
  // Eliminar puntos y guión del rut
  rut = rut.replace(/\./g,'').replace(/\-/g,'');
  // Validar que el rut tenga el formato correcto
  var pattern = /^\d{7,8}[0-9K]$/;
  if (!pattern.test(rut)) {
    respuesta.innerHTML = `<div class="alert alert-danger" role="alert">
      El rut ingresado no es válido
    </div>`;
    return false;
  }
  // Validar dígito verificador
  var rutNumber = parseInt(rut.slice(0, -1), 10);
  var verifDigit = rut.slice(-1).toUpperCase();
  var factor = 2;
  var sum = 0;
  for (var i = rutNumber.toString().length - 1; i >= 0; i--) {
    factor = factor > 7 ? 2 : factor;
    sum += parseInt(rutNumber.toString().charAt(i), 10) * factor;
    factor++;
  }
  var dv = 11 - (sum % 11);
  dv = (dv === 11) ? 0 : (dv === 10) ? 'K' : dv;
  if (dv.toString() !== verifDigit) {
    respuesta.innerHTML = `<div class="alert alert-danger" role="alert">
      El rut ingresado no es válido
    </div>`;
    return false;
  }
  return true;
}


function validateEmail() {
  const emailInput = document.querySelector('input[type="email"]');
  const emailValue = emailInput.value.trim();

  // Verificar que el email tenga un formato válido
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!regex.test(emailValue)) {
    respuesta.innerHTML = `<div class="alert alert-danger" role="alert">
      El formato del correo electrónico no es válido
    </div>`;
    return false;
  }

  // Si pasa todas las validaciones, retornar true
  return true;
}


function selectOptionsCheckbox() {
  const radioButtons = document.querySelectorAll('input[type="radio"][name="entero"]');
  const errorElement = document.querySelector('#error');

  // Establecer listener en los radio buttons
  radioButtons.forEach(radioButton => {
    radioButton.addEventListener('change', () => {
      const checkedRadioButtons = Array.from(radioButtons).filter(rb => rb.checked);

      // Validar que se seleccionen al menos dos opciones
      if (checkedRadioButtons.length < 2) {
        errorElement.textContent = 'Debe seleccionar al menos dos opciones';
      } else {
        errorElement.textContent = '';
      }
    });
  });
}


formulario.addEventListener('submit', function(e){
    e.preventDefault();

    if (!validateLastName()) {
      return;
    }

    if(!validateAlias()){
      return;
    }

    if(!validateRut()){
      return;
    }

    if(!validateEmail()){
      return;
    }

    if(!selectOptionsCheckbox()){
      return;
    }
    
    var datos = new FormData(formulario);

    fetch('back.php',{
        method: 'POST',
        body: new URLSearchParams(new FormData(formulario))
    })
        .then( res => res.json())
        .then( data => {
            console.log(data)
            if(data === 'error'){
                console.log('error');
            }else{
                console.log('funciona');
            }
        })
})
