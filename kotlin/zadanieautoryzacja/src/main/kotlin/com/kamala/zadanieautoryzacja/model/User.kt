package com.kamala.zadanieautoryzacja.model

import javax.persistence.*

@Entity
class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Int = 0

    @Column(unique = true)
    val email: String = ""

    @Column(unique = true)
    val nick: String = ""

    @Column
    val password: String = ""
}