package FileUpload;

public class FileUploadDto {
	private String num; // 글 번호
	private String title; // 글 제목
	private String writer; // 작성자
	private String filename; // 파일이름
	private String content; //글 내용
	private String postdate; //작성일
	private String pass; //비밀번호
	private String readcount; //조회수
	
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPostdate() {
		return postdate;
	}
	public void setPostdate(String postdate) {
		this.postdate = postdate;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getReadcount() {
		return readcount;
	}
	public void setReadcount(String readcount) {
		this.readcount = readcount;
	}
	public FileUploadDto(String num, String title, String writer, String filename,
			String content, String postdate,
			String pass, String readcount) {
		super();
		this.num = num;
		this.title = title;
		this.writer = writer;
		this.filename = filename;
		this.content = content;
		this.postdate = postdate;
		this.pass = pass;
		this.readcount = readcount;
	}
	public FileUploadDto() {
		super();

	}
	@Override
	public String toString() {
		return "FileUploadDto [num=" + num + ", title=" + title + ", writer=" + writer + ", filename=" + filename
				+ ", content=" + content + ", postdate=" + postdate + ", pass=" + pass + ", readcount=" + readcount
				+ "]";
	}
	
	
}
