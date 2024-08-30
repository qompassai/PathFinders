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

text
gpg -d -o decrypted_file filename.gpg

or

text
gpg --decrypt --output decrypted_file filename.gpg

Additional notes:

    The -c flag is for symmetric encryption (password-based)
    The -e flag is for asymmetric encryption (public key-based)
    The -d flag is for decryption
    The -o flag specifies the output file
    The -r flag specifies the recipient (for asymmetric encryption)

