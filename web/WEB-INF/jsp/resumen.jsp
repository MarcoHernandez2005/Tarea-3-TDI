<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='UTF-8'>
    <title>Resumen - Financiera Huanca</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #2c3e50; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; padding: 20px; }
        .ventana { width: 600px; background: #d4d0c8; border: 2px solid #808080; border-radius: 4px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); overflow: hidden; }
        .barra-titulo { background: linear-gradient(180deg, #0a246a 0%, #3a6ea5 100%); color: white; padding: 8px 12px; font-weight: bold; font-size: 14px; }
        .contenido { background: #f0f0f0; padding: 25px; }
        .resumen-item { display: flex; justify-content: space-between; padding: 10px 15px; margin: 8px 0; background: white; border: 1px solid #c0c0c0; border-radius: 3px; font-size: 13px; }
        .resumen-item .label { font-weight: bold; color: #0a246a; }
        .resumen-item .value { color: #333; }
        .btn-volver { display: block; width: 150px; margin: 20px auto 0; text-align: center; padding: 10px; background: #d4d0c8; border: 2px solid; border-color: #ffffff #808080 #808080 #ffffff; text-decoration: none; color: #333; font-weight: bold; font-size: 14px; }
        .btn-volver:hover { background: #e0dcd4; }
        .exito { text-align:center; padding:15px; background:#d4edda; border:1px solid #c3e6cb; border-radius:5px; color:#155724; margin-bottom:20px; }
        .error { text-align:center; padding:15px; background:#f8d7da; border:1px solid #f5c6cb; border-radius:5px; color:#721c24; margin-bottom:20px; }
    </style>
</head>
<body>
<div class='ventana'>
  <div class='barra-titulo'>Financiera Huanca - Resumen</div>
  <div class='contenido'>

    <% if (Boolean.TRUE.equals(request.getAttribute("exito"))) { %>
        <div class='exito'><strong>Datos guardados en la base de datos correctamente</strong></div>
    <% } else { %>
        <div class='error'><strong>Error al guardar:</strong> ${mensajeError}</div>
    <% } %>

    <h2 style='text-align:center; color:#0a246a;'>Datos Capturados</h2>
    <div class='resumen-item'><span class='label'>Fecha</span><span class='value'>${fecha}</span></div>
    <div class='resumen-item'><span class='label'>Nombre</span><span class='value'>${nombre}</span></div>
    <div class='resumen-item'><span class='label'>Documento</span><span class='value'>${documento}</span></div>
    <div class='resumen-item'><span class='label'>Moneda</span><span class='value'>${moneda}</span></div>
    <div class='resumen-item'><span class='label'>Monto</span><span class='value'>${monto}</span></div>
    <div class='resumen-item'><span class='label'>Periodo</span><span class='value'>${periodo} meses</span></div>
    <div class='resumen-item'><span class='label'>Cuota</span><span class='value'>${cuota}</span></div>
    <div class='resumen-item'><span class='label'>TEA</span><span class='value'>${tea} %</span></div>
    <div class='resumen-item'><span class='label'>Fecha vencimiento</span><span class='value'>${fechaVencimiento}</span></div>

    <a href='inicio' class='btn-volver'>VOLVER</a>
  </div>
</div>
</body>
</html>