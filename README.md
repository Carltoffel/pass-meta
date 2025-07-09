# pass-meta

A minimal [pass](https://www.passwordstore.org/) extension to extract the password or metadata fields like `user:` or `url:` from an entry — designed for use in scripts.

## ✨ Example use case

You want to log into a service with credentials stored in `pass`, like:

```
pass show wiki.archlinux.org
```

Returns:

```
s3cr3tP@ssword!
user: carl
url: https://wiki.archlinux.org
```

Then:

```
pass meta wiki.archlinux.org           → s3cr3tP@ssword!
pass meta wiki.archlinux.org user      → carl
pass meta wiki.archlinux.org url       → https://wiki.archlinux.org
```

Use it in scripts:

```
xfreerdp3 /u:$(pass meta myserver user) /p:$(pass meta myserver)
```

## 🔧 Installation

1. Save the script in your password-store's `.extension` directory

2. Make it executable:

   ```
   chmod +x meta.bash
   ```

3. Enable extensions:

   ```
   export PASSWORD_STORE_ENABLE_EXTENSIONS=true
   ```

## 🚀 Usage

```
pass meta pass-name [key]
```

* Without a key: prints the password (first line)
* With a key: prints the value of the matching metadata field (e.g. `user:`) — without the prefix

## 📄 License

GPL-3.0-or-later – see LICENSE file.
