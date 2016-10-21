package com.haoche.bos.datamapper;

/**
 * Created by york on 16/5/10.
 */
public class GroupDto {

    private Long id;
    private String groupName;
    private String groupDes;
    private String creator;
    private Long creatorId;

    private int isSelect;

    public int getIsSelect() {
        return isSelect;
    }

    public void setIsSelect(int isSelect) {
        this.isSelect = isSelect;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getGroupDes() {
        return groupDes;
    }

    public void setGroupDes(String groupDes) {
        this.groupDes = groupDes;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public Long getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(Long creatorId) {
        this.creatorId = creatorId;
    }

    @Override
    public String toString() {
        return "GroupDto{" +
                "id=" + id +
                ", groupName='" + groupName + '\'' +
                ", groupDes='" + groupDes + '\'' +
                ", creator='" + creator + '\'' +
                ", creatorId=" + creatorId +
                ", isSelect=" + isSelect +
                '}';
    }
}
