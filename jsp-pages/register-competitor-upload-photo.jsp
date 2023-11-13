<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.time.*, com.oreilly.servlet.MultipartRequest"%>
<%@include file="database-files/database-operations.jsp" %>

<%
    String fileName = request.getParameter("fileName");
    String loginId = request.getParameter("loginId");
    
    String folderName = "competition-photos";
    try{
        String path = System.getProperty("user.dir");
        String uploadFolderPath = path + File.separator +".."+File.separator+ "webapps" + File.separator + "photo-competition" + File.separator;
        boolean isExists = isDirectoryExists(path, folderName, out);
        if(!isExists){
            createDirectory(uploadFolderPath, folderName, out);
        }
        MultipartRequest m = new MultipartRequest(request, uploadFolderPath + folderName);
        changeFileName(fileName,  uploadFolderPath + folderName, loginId, out);
        out.print("Photo uploaded successfully.");  
    } catch(Exception e){
        out.println(" Exception: " +e);
    }
%>

<%!
    public static boolean isDirectoryExists(String path, String folderName, JspWriter out) throws Exception{
        boolean flag = false;
        try{
            File file = new File(path + folderName);
            if(file.exists()){
                flag = true;
            }
        } catch(Exception e){
            out.println(" isDirectoryExists: " +e);
        }
        return flag;
    }
%>

<%!
    public static void changeFileName(String fileName, String path, String loginId, JspWriter out) throws Exception{
        try{
            StringTokenizer splitString = new StringTokenizer(fileName, ".");
            splitString.nextToken(); // Its filename not an extension thats why we traverse it.
            String extension = splitString.nextToken();
            LocalDate currentDate = LocalDate.now();
            String newFileName = generateNewFileName(loginId) + "." + extension;
            File originalFile = new File(path + File.separator + fileName);
            File renameFile = new File(path + File.separator + newFileName);
            originalFile.renameTo(renameFile);
            storePhotoDetails(path + File.separator + newFileName, loginId, out);
        } catch(Exception e){
            out.println(" isDirectoryExists: " +e);
        }
    }
%>

<%!
    public static void storePhotoDetails(String path, String loginId, JspWriter out) throws Exception{
        try{
            String photoId = generatePrimaryKey("PR", "photo_register", "photo_id", out);
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "insert into photo_register(photo_id, photo, login_id) values('"+photoId+"', '"+path+"', '"+loginId+"')";
            stmt.executeUpdate(query);
        } catch(Exception e){
            out.println(" Store photo details exception: " +e);
        } finally {
            closeConnection();            
        }
    }
%>

<%!
    public static void createDirectory(String path, String folderName, JspWriter out) throws Exception {
        try{
            new File(path + folderName).mkdir();
        } catch(Exception e){
            out.println(" createDirectory: " +e);
        }
    }
%>


<%!
	public static String generateNewFileName(String loginId){
		LocalDate currentDate = LocalDate.now();
		LocalTime currentTime = LocalTime.now();
		
		return "PHOTO-" + loginId + "-" + currentDate.getYear() + "" + currentDate.getMonthValue() + "" + currentDate.getDayOfMonth() + "" +
							currentTime.getHour() + "" + currentTime.getMinute() + "" + currentTime.getSecond();
	}
%>
