package fileUpload;

public class BoardDto {
	private int no;
	private String writer;
	private String pwd;
	private String content;
	private String file;

	public BoardDto() {
	}

	public BoardDto(int no, String writer, String pwd, String content, String file) {
		setNo(no);
		setContent(content);
		setFile(file);
		setPwd(pwd);
		setWriter(writer);
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}
}
