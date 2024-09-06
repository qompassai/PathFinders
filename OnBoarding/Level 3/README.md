# Level 3- Let's encrypt & decrypt with gpg
To encrypt a file:

    Basic encryption:

    text
    gpg -c filename

This will prompt you for a passphrase and create an encrypted file named filename.gpg
Encrypt for a specific recipient (using their public key):

text
gpg -e -r recipient@email.com filename

or

text
gpg --encrypt --recipient recipient@email.com filename

Encrypt with a specific output filename:

text
gpg -e -r recipient@email.com -o encrypted_file.gpg original_file

To decrypt a file:

    Basic decryption:

    text
    gpg filename.gpg

This will prompt for the passphrase and create the decrypted file.
Decrypt to a specific output file:

```bash
gpg -d -o decrypted_file filename.gpg
```
or

```bash
gpg --decrypt --output decrypted_file filename.gpg
```

```Additional notes:

    The -c flag is for symmetric encryption (password-based)
    The -e flag is for asymmetric encryption (public key-based)
    The -d flag is for decryption
    The -o flag specifies the output file
    The -r flag specifies the recipient (for asymmetric encryption)
```
## ELI5: Secret keys lock up our secrets. Public keys allow people to share secrets with each other.

# Creating the right GPG key for the right job

## Understanding your gpg secret keys
- Review this example breakdown of the gpg --list-secret-keys command to understand what's going on under the hood of gpg. 

```bash
gpg --list-secret-keys
[keyboxd]
---------
1. sec   ed25519/ 0x7A3D62E9F1B8C405 2024-08-26 [SC]
2.      0929EC5B90A4EB9E37283E9CFFF8C01192806618
3. uid           [ultimate] **First and Last Name** (**yourmachine**) <**youremail.mail**>
4. ssb   cv25519 2024-08-26 [E]
5. ssb   ed25519 2024-08-26 [A]
```
- 1. sec indicates this is your secret (private) primary key. **DO NOT SHARE THIS**. 0x7A3D62E9F1B8C405 is **your key ID**. The 0x prefix is a universally recognized identifier for hexidecmial representations. ed25519 is the algorithm used (Edwards-curve Digital Signature Algorithm).  2024-08-26 is the creation date. [SC] means this key has Signing and Certification capabilities.
- 2.  0929EC5B90A4EB9E37283E9CFFF8C01192806618 is the full 40-character fingerprint of your primary key. It has the same value as a password, just more secure.
- 3. uid stands for User ID. [ultimate] is the trust level (highest for your own key). The rest is your name, comment (in parentheses), and email address that you input when you created the key. 
- 4. ssb indicates a secret subkey, cv25519 is the algorithm (Curve25519, used for encryption).[E] means this subkey is for Encryption.
- 5. [A] indicates this subkey is for authentication (using secure shell (SSH) to remote into another server, like Github), 2024-08-26 is the creation date of the key.



So now we've (at least) made one GPG key pair consisting of a private, secret key, and a public key. Great job! Now we're going to create specific subordinate keys under our primary key.
## **bash** is the default terminal setup for most versions of the GNU/Linux operating system (OS). **zsh** is the default for MacOS. When you see a code block with bash or zsh, know that you can use either for our puroses. Windows comes with powershell by default which does **NOT** work interchangably with zsh or bash. 

- View your gpg secret key ids
```bash
gpg --list-secret-keys
```

- View all of your public gpg keys (the ones you've generated and the ones that have been shared with you)
```bash
gpg --list-keys
```
- View only your gpg public keys
```bash
gpg --list-keys **your email**

```Example
gpg --list-keys map@qompass.ai
pub   ed25519/0x4F8B914D6026570F 2024-08-23 [SC]
      Key fingerprint = 0BFC 1A9D 6DB0 0C36 7679  BB22 4F8B 914D 6026 570F
      Keygrip = 4543C960454617019853D6EB182EBFE0431CEAF5
uid                   [ultimate] Matt Porter <map@qompass.ai>
sub   cv25519/0xDB8EDF1FEE97666C 2024-08-23 [E]
      Keygrip = C0988B3D68BCB3EBEB153B32B9C267F2B06D45B1
sub   ed25519/0x3F5972D11713FFB3 2024-08-23 [S]
      Keygrip = 00B42350EE1CD1CAC0966DC67108F514E7939FC4
sub   ed25519/0xC74C8202241A0751 2024-08-23 [SA]
      Keygrip = 762B6B5986C20F80798F9D1FA2C880FFCA1925E6
sub   ed25519/0x84F3B5E1DD2F9F5A 2024-08-25 [A]
      Keygrip = EB33C19C3FA8E5510CF9E469C81E225575CB1951
```

```Understanding the difference between public and private keys
1. Secret keys are used for decrypting messages sent to you and for signing messages you send. These should be kept private and secure.
2. Public keys are used for encrypting messages to send to others and for verifying signatures from others.These can be freely shared.
3. Secret keys are often marked with "sec" (secret) or "ssb" (secret subkey)
4. Public keys are marked with "pub" (public) or "sub" (public subkey)
5. The key ID, creation date, and expiration date (if any) are typically displayed
6. User IDs (email addresses, names) associated with each key are also shown.
7. You can import others' public keys to encrypt messages to them or verify their signature
8. Your public keys can be exported and shared, while your private keys should remain secure
```

- View your gpg key id in short hexidecimal format 

```bash
gpg --keyid-format 0xshort --list-keys
```
```Exlanation
1. gpg: This is the command to use the GNU Privacy Guard (GPG) software.
2. --keyid-format 0xshort: This option tells GPG to display key IDs in a short format (last 8 characters) with a "0x" prefix. Depending on your 
3. --list-keys: This instructs GPG to show a list of all public keys in your keyring.
```

- In order to add subordinate keys to your GPG key, you use the addkey command with the gpg cli

```bash
gpg --expert --edit-key "your email or key ID"
```
- then type addkey, you should see the below

```example
gpg> addkey
Please select what kind of key you want:
   (3) DSA (sign only)
   (4) RSA (sign only)
   (5) Elgamal (encrypt only)
   (6) RSA (encrypt only)
   (7) DSA (set your own capabilities)
   (8) RSA (set your own capabilities)
  (10) ECC (sign only)
  (11) ECC (set your own capabilities)
  (12) ECC (encrypt only)
  (13) Existing key
  (14) Existing key from card
Your selection? 
```
- type 11, you should see the below

```bash
Your selection? 11

Possible actions for this ECC key: Sign Authenticate 
Current allowed actions: Sign 

   (S) Toggle the sign capability
   (A) Toggle the authenticate capability
   (Q) Finished
```
- press S and A until you only see Sign, then press q. In the next menu press 1 to select Curve 25519, 1y for 1 year and select that this is correct.
```bash
Your selection? q
Please select which elliptic curve you want:
   (1) Curve 25519 *default*
   (2) Curve 448
   (3) NIST P-256
   (4) NIST P-384
   (5) NIST P-521
   (6) Brainpool P-256
   (7) Brainpool P-384
   (8) Brainpool P-512
   (9) secp256k1
Your selection? 1
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 1y
Key expires at Sat 06 Sep 2025 10:20:58 AM PDT
Is this correct? (y/N)
```
- verify the new key, which is the one that has [S] next to it. This public subkey only has signing capability, limiting any damage done in the event that the corresonding private key was compromised to only allow for a bad actor to replicate signing, and not encryption or authentication linked to your private key.
```bash
gpg --list-keys --keyid-format long, it should look like below

pub   ed25519/0x1234567890ABCDEF 2023-09-06 [SC]
      Key fingerprint = AAAA BBBB CCCC DDDD EEEE  FFFF 1234 5678 90AB CDEF
uid                   [ultimate] Your Name <your@email.com>
sub   ed25519/0x2345678901ABCDEF 2023-09-06 [S]
sub   ed25519/0x3456789012ABCDEF 2023-09-06 [A]
sub   cv25519/0x4567890123ABCDEF 2023-09-06 [E]
```
