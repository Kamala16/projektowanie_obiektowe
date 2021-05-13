package com.kamala.zadanieautoryzacja.authorize

import com.kamala.zadanieautoryzacja.model.User
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import com.kamala.zadanieautoryzacja.repository.Repository

@Service
class Authorize @Autowired constructor(val repository: Repository){

    fun register(user: User): User {
        return repository.save(user)
    }

    fun login(nick: String, password: String): User?{
        return repository.findByNickAndPassword(nick, password)
    }

    fun logout(nick: String): User?{
        return repository.findByNick(nick)
    }

}