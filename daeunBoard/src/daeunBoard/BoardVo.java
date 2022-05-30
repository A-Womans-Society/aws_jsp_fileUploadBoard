package daeunBoard;

public class BoardVo {
	int num;
	String title;
	String content;
	String file;
	String writer;
	int count;
	
	public BoardVo() {}
	
	public BoardVo(int num, String title, String content, String file, String writer, int count) {
		super();
		this.num = num;
		this.title = title;
		this.content = content;
		this.file = file;
		this.writer = writer;
		this.count = count;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	@Override
	public String toString() {
		return "boardVo [num=" + num + ", title=" + title + ", content=" + content + ", file=" + file + ", writer="
				+ writer + ", count=" + count + "]";
	}
	
	
	
}
