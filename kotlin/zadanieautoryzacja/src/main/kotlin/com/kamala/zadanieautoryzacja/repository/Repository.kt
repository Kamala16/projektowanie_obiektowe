package com.kamala.zadanieautoryzacja.repository

import com.kamala.zadanieautoryzacja.model.User
import com.sun.istack.Nullable
import org.springframework.data.repository.CrudRepository

interface Repository : CrudRepository<User, Int> {
    @Nullable
    fun findByNickAndPassword(nick: String, password: String): User

    @Nullable
    fun findByNick(nick: String): User
}