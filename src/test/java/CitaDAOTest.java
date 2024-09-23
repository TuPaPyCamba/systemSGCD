/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit3TestClass.java to edit this template
 */

import com.sgcd.dao.CitaDAO;
import com.sgcd.model.Cita;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import junit.framework.TestCase;

/**
 *
 * @author Vega
 */
public class CitaDAOTest extends TestCase {
    
    public CitaDAOTest(String testName) {
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

    public void testCrearCita() {
        int idpaciente = 38;
        int idmedico = 10;
        int idsucursal = 1;
        LocalDate fecha = LocalDate.of(2024, 9, 20);
        String hora = "11:30 PM";
        String descripcion = "Revision Mensual";
        CitaDAO citaDAO = new CitaDAO();
        boolean statusCreateCita = citaDAO.crearCita(idpaciente, idmedico, idsucursal, fecha, hora, descripcion);
        assertEquals(true, statusCreateCita);
    }
    
    public void testDeleteCita() throws SQLException {
        int id = 33;
        CitaDAO citaDAO = new CitaDAO();
        int deletedRegisters = citaDAO.delete(id);
        assertEquals(1, deletedRegisters);
    }
    
    public void testUpdateCita() throws SQLException {
        Cita cita = new Cita();
        cita.setId(29);
        cita.setIdPaciente(38);
        cita.setIdMedico(10);
        cita.setIdsucursal(1);
        cita.setFecha(LocalDate.of(2024, 9, 20));
        cita.setHora("10:30 PM");
        cita.setDescripcion("Update Test Desc");
        CitaDAO citaDAO = new CitaDAO();
        int registrosRealizados = citaDAO.update(cita);
        String textUpdateCita = (registrosRealizados == 1) ? "Se Actualizo La Cita Con El ID: " + cita.getId() : "Hubo Un Error Al Actualizar Los Datos De La Cita";
        System.out.println(textUpdateCita);
        assertEquals(1, registrosRealizados);
    }
    
    public void testObtenerCitasPorMedicoYDia() {
        CitaDAO citaDAO = new CitaDAO();
        int idmedico = 10;
        LocalDate fecha = LocalDate.of(2024, 9, 20);
        List<String> citas = citaDAO.obtenerCitasPorMedicoYDia(idmedico, fecha);
        for (String cita : citas) {
            System.out.println("Hora Cita Medico: " + cita);
        }
        assertNotNull(citas);
    }
    
    public void testObtenerCitasPorPacienteYDia() {
        CitaDAO citaDAO = new CitaDAO();
        int idpaciente = 38;
        LocalDate fecha = LocalDate.of(2024, 9, 20);
        List<String> citas = citaDAO.obtenerCitasPorPacienteYDia(idpaciente, fecha);
        for (String cita : citas) {
            System.out.println("Horas Cita Paciente: " + cita);
        }
        assertNotNull(citas);
    }
    
    public void testFindAllCitas() throws SQLException {
        CitaDAO citaDAO = new CitaDAO();
        List<Cita> citas = citaDAO.findAllCitas();
        System.out.println("Se Encontraron " + citas.size() + " Citas Registradas");
        for (Cita cita : citas) {
            System.out.println("-- DATOS CITA --");
            System.out.println("ID Cita: " + cita.getId());
            System.out.println("ID Medico: " + cita.getIdMedico());
            System.out.println("ID Paciente: " + cita.getIdPaciente());
            System.out.println("Fecha Cita: " + cita.getFecha());
            System.out.println("Descripcion: " + cita.getDescripcion());
        }
        assertNotNull(citas);
    }
    
    public void testObtenerTodasCitasMedico() {
        CitaDAO citaDAO = new CitaDAO();
        int idmedico = 10;
        LocalDate fecha = LocalDate.of(2024, 9, 20);
        List<Cita> citasMedico = citaDAO.obtenerTodasCitas(idmedico, fecha);
        System.out.println("Citas Encontradas para el Medico con ID: " + idmedico + " para el Dia: " + fecha);
        for (Cita cita : citasMedico) {
            System.out.println("-- DATOS CITA --");
            System.out.println("ID Cita: " + cita.getId());
            System.out.println("ID Medico: " + cita.getIdMedico());
            System.out.println("ID Paciente: " + cita.getIdPaciente());
            System.out.println("Fecha Cita: " + cita.getFecha());
            System.out.println("Descripcion: " + cita.getDescripcion());
        }
        assertNotNull(citasMedico);
    }
    
    public void testObtenerTodasCitasPorPaciente() {
        CitaDAO citaDAO = new CitaDAO();
        int idpaciente = 38;
        LocalDate fecha = LocalDate.of(2024, 9, 20);
        List<Cita> citasPaciente = citaDAO.obtenerTodasCitasPorPaciente(idpaciente, fecha);
        System.out.println("Citas Encontradas para el Medico con ID: " + idpaciente + " para el Dia: " + fecha);
        for (Cita cita : citasPaciente) {
            System.out.println("-- DATOS CITA --");
            System.out.println("ID Cita: " + cita.getId());
            System.out.println("ID Medico: " + cita.getIdMedico());
            System.out.println("ID Paciente: " + cita.getIdPaciente());
            System.out.println("Fecha Cita: " + cita.getFecha());
            System.out.println("Descripcion: " + cita.getDescripcion());
        }
        assertNotNull(citasPaciente);
    }
}
