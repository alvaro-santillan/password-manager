package com.example.hasher

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import at.favre.lib.crypto.bcrypt.BCrypt
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        submitPassButton.setOnClickListener {
            val password = passwordInput.text.toString().trim()
            val confirmPassword = confirmPasswordInput.text.toString().trim()

            if (password.isEmpty() || confirmPassword.isEmpty()) {
                Toast.makeText(this, "Both passwords must be entered", Toast.LENGTH_SHORT).show()
            } else if (password != confirmPassword) {
                Toast.makeText(this, "Passwords do not match", Toast.LENGTH_SHORT).show()
            } else {
                val passwordHash = BCrypt.withDefaults().hashToString(10, password.toCharArray())
                PasswordHash.text = passwordHash
                Log.d("password", "$passwordHash")
            }
        }

        submitButton.setOnClickListener {
            val password = inputPassword.text.toString().trim()

            if(password.isEmpty()) {
                Toast.makeText(this, "You must enter a password!", Toast.LENGTH_SHORT).show()
            } else {
                val result = BCrypt.verifyer().verify(password.toCharArray(), PasswordHash.text)

                if (result.verified) {
                    CompareHash.text = "Hashes match"
                } else {
                    CompareHash.text = "Hashes don't match"
                }
            }
        }
    }
}