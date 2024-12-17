package kdtweb.util;

public class Paging {
   
	private int totalRecords;   //? „ì²? ê²Œì‹œê¸? ?ˆ˜
	private int recordsPerPage;  //?•œ ?˜?´ì§??‹¹ ë³´ì—¬ì¤? ê²Œì‹œê¸? ?ˆ˜
	private int currentPage;  //?˜„?¬ ?˜?´ì§?
	private int totalPages;   //? „ì²? ?˜?´ì§?
	private int pagesPerGroup;  //?•œ ë²ˆì— ë³´ì—¬ì¤? ?˜?´ì§? ë²ˆí˜¸?˜ ?ˆ˜ (?˜ˆ:10?´ë©? 1~10, 11~20)  
    private int currentGroup;  //?˜„?¬ ?˜?´ì§? ê·¸ë£¹
	
	public Paging(int totalRecords, int recordsPerPage, int currentPage, int pagesPerGroup) {
		this.totalRecords = totalRecords;
		this.recordsPerPage = recordsPerPage;
		this.currentPage = currentPage;
		this.pagesPerGroup = pagesPerGroup;
		this.totalPages = (int)Math.ceil((double) totalRecords / recordsPerPage);
		this.currentGroup = (int) Math.ceil((double)currentPage / pagesPerGroup); 
	}
   
	//ë³´ì—¬ì§??Š” ?˜?´ì§? ê·¸ë£¹?—?„œ ì²? ë²ˆì§¸ ë²ˆí˜¸
	public int getStartPageOfGroup() {
		return (currentGroup - 1) * pagesPerGroup + 1;
	}
	
	//ë³´ì—¬ì§??Š” ?˜?´ì§? ê·¸ë£¹?—?„œ ë§ˆì?ë§? ë²ˆí˜¸
	public int getEndPageOfGroup() {
		int endPage = currentGroup * pagesPerGroup;
		return Math.min(endPage, totalPages);
	}
	
	//?˜„?¬ ?˜?´ì§??˜ ?‹œ?‘ ê²Œì‹œê¸? ë²ˆí˜¸
	public int getStartRecord() {
	   return (currentPage -1) * recordsPerPage;	
	}
	
	//? „ì²? ? ˆì½”ë“œ?ˆ˜ ê²Œí„°
	public int getTotalRecords() {
		return totalRecords;
	}
	
	//?•œ ?˜?´ì§??‹¹ ë³´ì—¬ì¤? ë²ˆí˜¸ ?ˆ˜ ê²Œí„°
	public int getRecordsPerPage() {
		return recordsPerPage;
	}
	
	//?˜„?¬ ?˜?´ì§? ë²ˆí˜¸ ê²Œí„°
	public int getCurrentPage() {
		return currentPage;
	}
	
	//? „ì²? ?˜?´ì§?
	public int getTotalPages() {
		return totalPages;
	}
	
	public int getPagesPerGroup() {
		return pagesPerGroup;
	}
}
