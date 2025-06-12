package collegeproj;
public class Grade {
    private String studentId;
    private String grade;

    public Grade(String studentId, String grade) {
        this.studentId = studentId;
        this.grade = grade;
    }

    public String getStudentId() {
        return studentId;
    }

    public String getGrade() {
        return grade;
    }
}
