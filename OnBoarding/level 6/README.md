# Lesson Plan: Introduction to Authenticated Encryption

## Objective: By the end of this lesson, you will understand the basics of authenticated encryption, solve a simple math problem illustrating the concept, and gain hands-on experience with GPG, SSH, and SSL.


---

## 1: Understanding Authenticated Encryption

### 1.1 What is Authenticated Encryption?

Authenticated encryption combines encryption (confidentiality) and authentication (integrity and authenticity) into a single step. It ensures that:

**Confidentiality**: Only authorized parties can read the message.

**Integrity**: The message has `not` been altered in transit.

**Authenticity**: The message comes from a legitimate source.

### 1.2 Why is it Important?

Traditional encryption methods only provide confidentiality. Without authentication, an attacker could alter the message or inject fake messages without detection.


---

## Part 2: The Math – Calculating a Simple MAC


We'll start by putting pen to paper to understand how authentication works at a high level using a Message Authentication Code (MAC).

### 2.1  Help Alice and bob `mac` on each other

Alice wants to send the message "HELLO" to Bob. They share a secret `key` K = 3. We'll use a simple algorithm:

1. Encrypt the message by shifting each letter by the key (in this we use the Caesar cipher).

1.1 A modulus is the remainder after division of one number by another. In mathematics, it's often written as:
`a mod n = r`
Where:
'a' is the number being divided
'n' is the number we're dividing by (called the modulus)
'r' is the remainder
For example:
7 mod 3 = 1 (because 7 ÷ 3 = 2 remainder 1)
15 mod 4 = 3 (because 15 ÷ 4 = 3 remainder 3)
In cryptography, modular arithmetic is often used to "wrap around" numbers, keeping them within a certain range. This is particularly useful for alphabetic ciphers where we need to stay within the range of available letters.

1.2 - But 7/3=2.33333, how is that mod 1??


- Divide 7 by 3:
3 goes into 7 two times (2 x 3 = 6)
This gives us our `quotient` of 2
When we Calculate the remainder:

`7 - (2 x 3) = 7 - 6 = 1`

This 1 is our remainder
So, in the context of modular arithmetic:

`7 mod 3 = 1`

The statement "7 ÷ 3 = 2 remainder 1" is the `integer` division representation, which is equivalent to the modulus operation.

Similarly, for 15 mod 4:
15 ÷ 4 = 3 in integer division (4 goes into 15 three times)
`15 - (3 x 4) = 15 - 12 = 3 (remainder)`

Therefore, `15 mod 4 = 3`

- Programming, mathematics and data science all interact with modular arithmetic in different ways, all valid.  We're often concerned with these integer results rather than the floating-point quotients because of the exacting nature inherent in integer arithmetic. In contrast, floating-point arithmetic can introduce small rounding errors that open opportunity which runs counter to the needs of the precise, predictable results necessary when sharing sensitive information. Enter cryptography.

- This integer-based approach is fundamental to many algorithms, including those used in cryptography like the Caesar cipher.
2. Compute the MAC by adding the numerical values of the plaintext letters and taking the modulus with 26.


2.2 By the Numbers

Step 1: Encrypt the Message

Assign numerical values to each letter (A=0, B=1, ..., Z=25), then shift:

```
H (7) → (7 + 3) mod 26 = 10 → K

E (4) → (4 + 3) mod 26 = 7 → H

L (11) → (11 + 3) mod 26 = 14 → O

L (11) → (11 + 3) mod 26 = 14 → O

O (14) → (14 + 3) mod 26 = 17 → R
```

Encrypted Message `KHOOR`

Step 2: Compute the MAC

Sum the numerical values of the plaintext letters:

```
H → 7

E → 4

L → 11

L → 11

O → 14
```

Total Sum: `7 + 4 + 11 + 11 + 14 = 47`

Compute the MAC:

`MAC: 47 mod 26 = 21`

- Step 3: Send Encrypted Message and MAC

Alice sends the encrypted message KHOOR and the MAC 21 to Bob.

2.3 Your turn

- Your Message
`Message: "WORLD"`

`Secret Key: K = 5`

Tasks:

1. Encrypt the message using the Caesar cipher with key 5.

2. Compute the MAC by summing the numerical values of the plaintext letters and taking modulus 26.

Hints:

Assign numerical values: A=0, B=1, ..., Z=25.

Shift letters by adding the key and wrapping around at 25 (if necessary).

2.4 Solution -No peeking!

Encrypt the Message

Assign numerical values:

```
W → 22

O → 14

R → 17

L → 11

D → 3
```

Shift each letter by 5:
```
W: (22 + 5) mod 26 = 1 → B

O: (14 + 5) mod 26 = 19 → T

R: (17 + 5) mod 26 = 22 → W

L: (11 + 5) mod 26 = 16 → Q

D: (3 + 5) mod 26 = 8 → I
```

Encrypted Message: `BTWQI`

Compute the MAC

Sum of plaintext numerical values:

`22 + 14 + 17 + 11 + 3 = 67`

Compute the MAC:

`MAC: 67 mod 26 = 15`

---

## Part 3: Hands-On with Open-Source encryption 

GPG (GNU Privacy Guard) allows you to encrypt and sign messages.

3.1 Install GPG

** Linux/MacOS: GPG is usually pre-installed. If not, install via your package manager.

Windows: Download from GPG4Win.

3.2 Generate a Key Pair

gpg --full-generate-key

Select RSA and RSA.

Key size: 2048 bits.

Validity: 0 (does not expire).

Provide your name and email.

3.3 Exchange Public Keys

Imagine you have a friend named Bob.

Export your public key:

```gpg --export --armor "Your Name" > your_public_key.asc
```
Import Bob's public key:

```
gpg --import bob_public_key.asc
```
3.4 Encrypt and Sign a Message

Create a file message.txt with the content "Hello, Bob!"

gpg --encrypt --sign --armor -r "Bob" message.txt

This creates message.txt.asc, an encrypted and signed message.


3.5 Decrypt a Message

If Bob sends you an encrypted message encrypted_message.asc, decrypt it:

gpg --decrypt encrypted_message.asc


---

## Part 4: Secure Shell (SSH)

SSH allows secure remote login and command execution.

4.1 Generate SSH Keys

ssh-keygen -t rsa -b 2048 -C "your_email@example.com"

Press Enter to accept the default file location.

Set a passphrase (optional but recommended).


4.2 Copy Public Key to Server

ssh-copy-id user@remote_server

This copies your public key to the ~/.ssh/authorized_keys file on the server.


4.3 Connect to the Server

ssh user@remote_server

You should now connect without a password (if you didn't set a passphrase) or by entering your key's passphrase.



---

Part 5: Understanding SSL/TLS

SSL/TLS protocols secure internet communication.

5.1 Exploring HTTPS

Use a web browser to visit a secure site like https://example.com.

Click on the padlock icon to view the site's SSL certificate.

Note the certificate issuer and validity period.

5.2 Simple SSL Server with OpenSSL

Let's create a self-signed certificate and run a simple SSL server.

Step

Step 1: Generate a Self-Signed Certificate

```openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365
```

Set a passphrase and provide certificate details.

When prompted for "Common Name," enter "localhost".



Step 2: Start a Simple SSL Server
```
openssl s_server -accept 4433 -cert cert.pem -key key.pem
```

Step 3: Connect to the Server

Open another terminal and run:

openssl s_client -connect localhost:4433

You'll see the SSL handshake and can type messages.



---

Conclusion

In this lesson, you've:

Learned the basics of authenticated encryption.

Solved a math problem illustrating encryption and MAC computation.

Practiced encrypting and signing messages with GPG.

Set up SSH keys for secure authentication.

Explored SSL/TLS using OpenSSL.



---

Additional Resources

Books:

Applied Cryptography by Bruce Schneier

Websites:

GPG Manual

OpenSSL Documentation


---


