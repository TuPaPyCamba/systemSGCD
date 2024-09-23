/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit3TestClass.java to edit this template
 */

import com.sgcd.dao.ConsultaDAO;
import com.sgcd.model.Consulta;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import junit.framework.TestCase;

/**
 *
 * @author Vega
 */
public class ConsultaDAOTest extends TestCase {
    
    public ConsultaDAOTest(String testName) {
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

    public void testCrearConsulta() {
        int idpaciente = 38;
        int idmedico = 10;
        int idsucursal = 1;
        LocalDate fecha = LocalDate.of(2024, 9, 20);
        String hora = "18:00 PM";
        String descripcion = "Revision de Rutina";
        ConsultaDAO consultaDAO = new ConsultaDAO();
        boolean statusCreateConsulta = consultaDAO.crearConsulta(idpaciente, idmedico, idsucursal, fecha, hora, descripcion);
        assertEquals(true, statusCreateConsulta);
    }
    
    public void testUpdateConsulta() throws SQLException {
        Consulta consulta = new Consulta();
        consulta.setId(11);
        consulta.setIdPaciente(38);
        consulta.setIdMedico(10);
        consulta.setIdsucursal(1);
        consulta.setFecha(LocalDate.of(2024, 9, 30));
        consulta.setHora("17:00 PM");
        consulta.setDescripcion("Revision de Rutina");
        ConsultaDAO consultaDAO = new ConsultaDAO();
        int registrosRealizados = consultaDAO.update(consulta);
        String textUpdateConsulta = (registrosRealizados == 1) ? "Se Actualizo La Cita Con El ID: " + consulta.getId() : "Hubo Un Error Al Actualizar La Consulta";
        System.out.println(textUpdateConsulta);
        assertEquals(1, registrosRealizados);
    }
    
    public void testFindAllCitas() throws SQLException{
        ConsultaDAO consultaDAO = new ConsultaDAO();
        List<Consulta> consultas = consultaDAO.findAllConsultas();
        String textConsultasAll = (consultas.size() > 0) ? "Se Encontraton " + consultas.size() + " Consultas Registradas" : "No Se Encontraron Consultas Registradas";
        System.out.println(textConsultasAll);
        System.out.println();
        for (Consulta consulta : consultas) {
            System.out.println("-- DATOS CONSULTA -- ");
            System.out.println("ID Cita: " + consulta.getId());
            System.out.println("ID Medico: " + consulta.getIdMedico());
            System.out.println("ID Paciente: " + consulta.getIdPaciente());
            System.out.println("ID Sucursal: " + consulta.getIdsucursal());
            System.out.println("Fecha Consulta: " + consulta.getFecha());
            System.out.println("Hora Consulta: " + consulta.getHora());
            System.out.println("Descripcion: " + consulta.getDescripcion());
        }
        assertNotNull(consultas);
    }
    
}
