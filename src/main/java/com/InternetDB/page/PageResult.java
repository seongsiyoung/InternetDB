package com.InternetDB.page;


public class PageResult {
    private int page;
    private int size;
    private int total;
    private int start;
    private int end;

    private boolean prev;
    private boolean next;


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
