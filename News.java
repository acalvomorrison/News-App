public class News {
    private String title;
    private String date;
    private String displayedDate;
    private String creator;
    private String content;
    private String description;
    private String facebookLink;
    private String twitterLink;
    private String link;

    public News(String title, String date, String creator, String content, String description, String facebookLink, String twitterLink, String link, String displayedDate) {
        this.title = title;
        this.date = date;
        this.creator = creator;
        this.content = content;
        this.description = description;
        this.facebookLink = facebookLink;
        this.twitterLink = twitterLink;
        this.link = link;
        this.displayedDate = displayedDate;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getFacebookLink() {
        return facebookLink;
    }

    public void setFacebookLink(String facebookLink) {
        this.facebookLink = facebookLink;
    }

    public String getTwitterLink() {
        return twitterLink;
    }

    public void setTwitterLink(String twitterLink) {
        this.twitterLink = twitterLink;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getDisplayedDate() {
        return displayedDate;
    }

    public void setDisplayedDate(String displayedDate) {
        this.displayedDate = displayedDate;
    }
}
