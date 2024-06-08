package com.InternetDB.page;


public class PageResult {
    private int page; //현재 페이지
    private int size; //불러온 컨텐츠의 개수
    private int total;// 조회되는 총 컨텐츠의 수
    private int start;//시작 페이지
    private int end;//마지막 페이지
    private boolean prev;//이전 페이지 유무
    private boolean next;//다음 페이지 유무


    public PageResult(int page, int size, int total){
        this.page = page;
        this.size = size;
        this.total = total;
        this.end = (int)(Math.ceil(this.page / 10.0)) * 10;
        this.start = this.end - 9;
        int last = (int)(Math.ceil((total/(double)size)));
        this.end = Math.min(end, last);
        this.prev = this.start > 1;
        this.next = total > this.end * this.size;
    }


    public int getPage() {
        return page;
    }

    public int getSize() {
        return size;
    }

    public int getTotal() {
        return total;
    }

    public int getStart() {
        return start;
    }

    public int getEnd() {
        return end;
    }

    public boolean isPrev() {
        return prev;
    }

    public boolean isNext() {
        return next;
    }
}
