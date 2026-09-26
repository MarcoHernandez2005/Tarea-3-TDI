<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='UTF-8'>
    <title>Financiera Huanca</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #2c3e50; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; padding: 20px; }
        .ventana { width: 700px; background: #d4d0c8; border: 2px solid #808080; border-radius: 4px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); overflow: hidden; }
        .barra-titulo { background: linear-gradient(180deg, #0a246a 0%, #3a6ea5 100%); color: white; padding: 8px 12px; font-weight: bold; font-size: 14px; display: flex; justify-content: space-between; align-items: center; }
        .botones-ventana { display: flex; gap: 5px; }
        .btn-ventana { width: 20px; height: 20px; background: #c0c0c0; border: 1px solid #808080; border-radius: 2px; font-size: 12px; cursor: pointer; display: flex; align-items: center; justify-content: center; }
        .btn-ventana.cerrar { background: #e74c3c; color: white; }
        .pestanas { display: flex; background: #c0c0c0; border-bottom: 1px solid #808080; padding: 0 5px; }
        .pestana { padding: 8px 20px; background: #d4d0c8; border: 1px solid #808080; border-bottom: none; margin-top: 5px; margin-right: 2px; cursor: pointer; font-size: 13px; border-radius: 4px 4px 0 0; }
        .pestana.activa { background: #f0f0f0; font-weight: bold; border-bottom: 1px solid #f0f0f0; margin-bottom: -1px; }
        .contenido { background: #f0f0f0; padding: 20px; min-height: 300px; }
        .panel { display: none; }
        .panel.activo { display: block; }
        .campo { margin-bottom: 15px; display: flex; align-items: center; }
        .campo label { width: 130px; font-size: 13px; color: #333; font-weight: bold; }
        .campo input[type='text'], .campo input[type='date'], .campo input[type='number'] { flex: 1; padding: 6px 8px; border: 1px solid #808080; background: white; font-size: 13px; border-radius: 2px; }
        .campo .unidad { margin-left: 10px; font-size: 13px; color: #333; }
        .radio-group { display: flex; flex-direction: column; gap: 8px; }
        .radio-group label { display: flex; align-items: center; font-weight: normal; cursor: pointer; }
        .radio-group input { margin-right: 8px; }
        .btn-aceptar { background: #d4d0c8; border: 2px solid; border-color: #ffffff #808080 #808080 #ffffff; padding: 10px 40px; font-size: 14px; font-weight: bold; cursor: pointer; margin-top: 20px; display: block; margin-left: auto; }
        .btn-aceptar:hover { background: #e0dcd4; }
        .btn-aceptar:active { border-color: #808080 #ffffff #ffffff #808080; }
    </style>
</head>
<body>
<div class='ventana'>
  <div class='barra-titulo'>
    <span>Financiera Huanca</span>
    <div class='botones-ventana'>
      <div class='btn-ventana'>_</div>
      <div class='btn-ventana'>□</div>
      <div class='btn-ventana cerrar'>✕</div>
    </div>
  </div>
  <div class='pestanas'>
    <div class='pestana activa' onclick="cambiarPestana('datosPersonales', this)">Datos personales</div>
    <div class='pestana' onclick="cambiarPestana('datosCredito', this)">Datos del crédito</div>
  </div>
  <div class='contenido'>
    <form action='guardarCredito' method='POST' onsubmit='return validarFechas()'>
      <div id='datosPersonales' class='panel activo'>
        <div class='campo'>
          <label>Fecha</label>
          <input type='date' name='fecha' id='fecha' required>
        </div>
        <div class='campo'>
          <label>Nombre completo</label>
          <input type='text' name='nombre' placeholder='Ej: Juan Pérez' required>
        </div>
        <div class='campo'>
          <label>Documento</label>
          <input type='text' name='documento' placeholder='Ej: 12345678' required>
        </div>
      </div>
      <div id='datosCredito' class='panel'>
        <div class='campo'>
          <label>Moneda</label>
          <div class='radio-group'>
            <label><input type='radio' name='moneda' value='Soles' checked> Soles (S/.)</label>
            <label><input type='radio' name='moneda' value='Dólares'> Dólares (US$)</label>
          </div>
        </div>
        <div class='campo'>
          <label>Monto</label>
          <input type='number' name='monto' placeholder='Ej: 5100' min='0' step='0.01' required>
        </div>
        <div class='campo'>
          <label>Periodo</label>
          <input type='number' name='periodo' placeholder='Ej: 12' min='1' max='60' required>
          <span class='unidad'>meses</span>
        </div>
        <div class='campo'>
          <label>Cuota</label>
          <input type='number' name='cuota' placeholder='Ej: 1000' min='0' step='0.01' required>
        </div>
        <div class='campo'>
          <label>TEA</label>
          <input type='number' name='tea' placeholder='Ej: 10' step='0.01' required>
          <span class='unidad'>%</span>
        </div>
        <div class='campo'>
          <label>Fecha vencimiento</label>
          <input type='date' name='fecha_vencimiento' id='fechaVencimiento' required>
        </div>
      </div>
      <button type='submit' class='btn-aceptar'>ACEPTAR</button>
    </form>
  </div>
</div>
<script>
function cambiarPestana(id, elemento) {
    document.querySelectorAll('.panel').forEach(function(p) { p.classList.remove('activo'); });
    document.querySelectorAll('.pestana').forEach(function(p) { p.classList.remove('activa'); });
    document.getElementById(id).classList.add('activo');
    elemento.classList.add('activa');
}
function validarFechas() {
    var fecha = document.getElementById('fecha').value;
    var fechaVencimiento = document.getElementById('fechaVencimiento').value;
    if (fecha && fechaVencimiento) {
        if (fechaVencimiento < fecha) {
            alert('La fecha de vencimiento no puede ser anterior a la fecha de solicitud.');
            return false;
        }
    }
    return true;
}
</script>
</body>
</html>