package com.kamala.zadanieautoryzacja.api

import com.kamala.zadanieautoryzacja.authorize.Authorize
import com.kamala.zadanieautoryzacja.model.User
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("authorize")
class Controller @Autowired constructor(val authorize: Authorize){

    @PostMapping("/register")
    fun register(@RequestBody user: User): User {
        return authorize.register(user)
    }

    @GetMapping("/login")
    fun login(@RequestParam("nick") nick: String, @RequestParam("password") password: String): User {
        return authorize.login(nick, password)!!
    }

    @GetMapping("/logout")
    fun logout(@RequestParam("nick") nick: String): User {
        return authorize.logout(nick)!!
    }
}