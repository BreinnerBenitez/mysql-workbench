package metadatos;

import java.sql.*;

public class InfoMetadatos {

	public static void main(String[] args) {
		
		//mostrarInfo_BDD();
		TablaInfo();
	}

	
	static void mostrarInfo_BDD() {
		
		
		Connection conexion =null;
		String usuario = "root";
		String contraseña = "";
		String link = "jdbc:mysql://localhost/pildoras";

		try {

			conexion = DriverManager.getConnection(link, usuario, contraseña);
			
			// obtencion de meta datos
			
			DatabaseMetaData datosBD =  conexion.getMetaData();
			
			//mostrar
			
			System.out.println("nombre del gestor: "+datosBD.getDatabaseProductName());
			System.out.println("version del gestor: "+datosBD.getDatabaseProductVersion());
			System.out.println("driver de la base de datos:"+datosBD.getDriverName());
			System.out.println ("version del dirver : "+datosBD.getDriverVersion());
		
		}catch(Exception e) {
			
			
			System.out.print("error de conexion");
			
		}finally {
			
			try {
				conexion.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
	}
	
	static void TablaInfo() {
		
		
		Connection conexion =null;
		String usuario = "root";
		String contraseña = "";
		String link = "jdbc:mysql://localhost/pildoras";

		try {

			conexion = DriverManager.getConnection(link, usuario, contraseña);
			ResultSet rs =null;
			// obtencion de meta datos
			
			DatabaseMetaData datosBD =  conexion.getMetaData();
			
			//listas de tabla
			
			System.out.println("lista de tablas");
			
			rs= datosBD.getTables("pildoras", null, null, new String []{"TABLE"});
			
			while(rs.next()) {
				
				
				System.out.println(rs.getString("TABLE_NAME"));
				
			}
			
			System.out.println("");
			
			System.out.println("campos de productos");
			
			rs= datosBD.getColumns("pildoras", null,"producto", null);
			
				while(rs.next()) {
				
				
				System.out.println(rs.getString("COLUMN_NAME"));
				
			}
			
		
			
		}catch(Exception e) {
			
			
			
		}finally {
			
			try {
				conexion.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
	}
}
