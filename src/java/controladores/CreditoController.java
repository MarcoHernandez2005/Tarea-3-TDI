package controladores;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import java.sql.*;

@Controller
public class CreditoController {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/test?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Tony2005*";

    @RequestMapping(value = "/inicio", method = RequestMethod.GET)
    public String mostrarFormulario() {
        return "formulario";
    }

    @RequestMapping(value = "/guardarCredito", method = RequestMethod.POST)
    public String guardarDatos(
            @RequestParam("fecha") String fecha,
            @RequestParam("nombre") String nombre,
            @RequestParam("documento") String documento,
            @RequestParam("moneda") String moneda,
            @RequestParam("monto") String monto,
            @RequestParam("periodo") String periodo,
            @RequestParam("cuota") String cuota,
            @RequestParam("tea") String tea,
            @RequestParam("fecha_vencimiento") String fechaVencimiento,
            Model model) {

        boolean guardadoPersonales = false;
        boolean guardadoCredito = false;
        String mensajeError = "";

        try {
            // 1. Registrar el driver explícitamente ANTES de intentar conectar
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 2. Abrir la conexión
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                
                String sqlPersonales = "INSERT INTO Datos_Personales (nombre, documento) VALUES (?, ?)";
                try (PreparedStatement psPersonales = conn.prepareStatement(sqlPersonales)) {
                    psPersonales.setString(1, nombre);
                    psPersonales.setString(2, documento);
                    if (psPersonales.executeUpdate() > 0) guardadoPersonales = true;
                }

                String sqlCredito = "INSERT INTO Datos_Credito (fecha, periodo, moneda, monto, cuota, tea, vencimiento) VALUES (?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement psCredito = conn.prepareStatement(sqlCredito)) {
                    psCredito.setString(1, fecha);
                    psCredito.setInt(2, Integer.parseInt(periodo));
                    psCredito.setString(3, moneda);
                    psCredito.setDouble(4, Double.parseDouble(monto));
                    psCredito.setDouble(5, Double.parseDouble(cuota));
                    psCredito.setDouble(6, Double.parseDouble(tea));
                    psCredito.setString(7, fechaVencimiento);
                    if (psCredito.executeUpdate() > 0) guardadoCredito = true;
                }
            }
        } catch (Exception e) {
            mensajeError = "Error al conectar o guardar: " + e.getMessage();
        }

        model.addAttribute("exito", guardadoPersonales && guardadoCredito);
        model.addAttribute("mensajeError", mensajeError);
        model.addAttribute("fecha", fecha);
        model.addAttribute("nombre", nombre);
        model.addAttribute("documento", documento);
        model.addAttribute("moneda", moneda);
        model.addAttribute("monto", monto);
        model.addAttribute("periodo", periodo);
        model.addAttribute("cuota", cuota);
        model.addAttribute("tea", tea);
        model.addAttribute("fechaVencimiento", fechaVencimiento);

        return "resumen";
    }
}