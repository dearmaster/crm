package com.master.crm.model;

import com.master.crm.enums.UserStatusType;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "credential_tbl", uniqueConstraints = { @UniqueConstraint(columnNames = { "username" }) })
public class Credential {

    @Id
    @Basic(optional = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;
    @Column(name = "username")
    private String username;
    @Column(name = "password")
    private String password;
    @Column(name = "status")
    private UserStatusType status;
    @Column(name = "registerDate")
    private Date registerDate;

    public Credential() {
    }

    public Credential(String username, String password, UserStatusType status, Date registerDate) {
        this.username = username;
        this.password = password;
        this.status = status;
        this.registerDate = registerDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public UserStatusType getStatus() {
        return status;
    }

    public void setStatus(UserStatusType status) {
        this.status = status;
    }

    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }

    @Override
    public String toString() {
        return "Credential{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", status=" + status +
                ", registerDate=" + registerDate +
                '}';
    }
}