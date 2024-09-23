/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit3TestClass.java to edit this template
 */

import com.sgcd.dao.SucursalDao;
import com.sgcd.model.Sucursal;
import java.sql.SQLException;
import junit.framework.TestCase;

/**
 *
 * @author Vega
 */
public class SucursalDAOTest extends TestCase {
    
    public SucursalDAOTest(String testName) {
        super(testName);
    }
    
    @Override
    protected void setUp() throws Exception {
        super.setUp();
    }
    
    @Override
    protected void tearDown() throws Exception {
        super.tearDown();
    }

    public void testCrearSucursal() throws SQLException {
        SucursalDao sucursalDAO = new SucursalDao();
        Sucursal sucursal = new Sucursal(0, "Farmacia Similares", "Av. Moliere", "+525512345678", "Cdmx", "Cdmx", "Mexico");
        int statusCreateSucursal = sucursalDAO.createSucursal(sucursal);
        String textCreateSucursal = (statusCreateSucursal == 1) ? "Sucursal Creada con Exito" : "Ocurrio un Error al Crear la Sucursal";
        System.out.println(textCreateSucursal);
        assertEquals(1, statusCreateSucursal);
    }
    
    public void testActualizarSucursal() throws SQLException {
        SucursalDao sucursalDAO = new SucursalDao();
        Sucursal sucursal = new Sucursal();
        sucursal.setIdsucursal(3);
        sucursal.setNombre("Farmacia Test");
        sucursal.setDireccion("Av. Independencia");
        sucursal.setTelefono("+525587654321");
        sucursal.setCiudad("Cdmx");
        sucursal.setEstado("Cdmx");
        sucursal.setPais("Mexico");
        int statusUpdateSucursal = sucursalDAO.actualizarSucursal(sucursal);
        String textUpdateSucursal = (statusUpdateSucursal == 1) ? "Sucursal Actualizada Correctamente" : "Hubo Un Problema al Actualizar la Sucursal";
        System.out.println(textUpdateSucursal);
        assertEquals(1, statusUpdateSucursal);
    }
    
    public void testObtenerSucursalesPorId() throws SQLException {
        int idsucursal = 1;
        SucursalDao sucursalDAO = new SucursalDao();
        Sucursal sucursalPorId = sucursalDAO.obtenerSucursalPorId(idsucursal);
        if (sucursalPorId != null) {
            System.out.println("Se Encontro una Sucursal con el ID: " + idsucursal);
            System.out.println("ID Sucursal: " + sucursalPorId.getIdsucursal());
            System.out.println("Nombre: " + sucursalPorId.getNombre());
            System.out.println("Direccion: " + sucursalPorId.getDireccion());
            System.out.println("Telefono: " + sucursalPorId.getTelefono());
            System.out.println("ID Sucursal: " + sucursalPorId.getIdsucursal());
            System.out.println("Ciudad: " + sucursalPorId.getCiudad());
            System.out.println("Estado: " + sucursalPorId.getEstado());
            System.out.println("Pais: " + sucursalPorId.getPais());
        } else {
            System.out.println("No Se Encontro Alguna Sucursal con el ID: " + idsucursal);
        }
        assertNotNull(sucursalPorId);
    }
}
