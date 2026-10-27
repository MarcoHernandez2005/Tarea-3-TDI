package modelos;

public class Gasto {
    private int id;
    private String fecha;
    private String mes;
    private String tarjeta;
    private String transaccion;
    private Double gasto;
    private Double pago;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFecha() { return fecha; }
    public void setFecha(String fecha) { this.fecha = fecha; }

    public String getMes() { return mes; }
    public void setMes(String mes) { this.mes = mes; }

    public String getTarjeta() { return tarjeta; }
    public void setTarjeta(String tarjeta) { this.tarjeta = tarjeta; }

    public String getTransaccion() { return transaccion; }
    public void setTransaccion(String transaccion) { this.transaccion = transaccion; }

    public Double getGasto() { return gasto; }
    public void setGasto(Double gasto) { this.gasto = gasto; }

    public Double getPago() { return pago; }
    public void setPago(Double pago) { this.pago = pago; }
}