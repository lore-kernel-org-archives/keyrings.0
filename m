From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 27 Sep 2018 13:14:29 +0000
Subject: [PATCH v2 0/7] keyctl_dh_compute_kdf touchups
Message-Id: <20180927131436.23328-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

If splitting or squasing patches is preferred, I can do that too.

Thanks,

--Ben

---
Changes from the previous patches:

  - fix another `error` string which didn't match
  - mention KEY_REQKEY_DEFL_USER_SESSION_KEYRING in the manpage
  - fix the declaration for const-ification
  - various typo fixes

Ben Boeckel (7):
  keyctl: fix error path message names
  keyctl_dh_compute.3: mention /proc/crypto for hashnames
  keyctl_dh_compute.3: clarify keyctl_dh_compute_kdf
  keyctl_dh_compute_kdf: const-ify input parameters
  keyctl_dh_compute_kdf: use a void* for opaque data
  keyctl_set_reqkey_keyring.3: mention
    KEY_REQKEY_DEFL_USER_SESSION_KEYRING
  typos: fix various typos

 dns.afsdb.c                     |  2 +-
 key.dns_resolver.c              |  2 +-
 keyctl.c                        |  8 ++++----
 keyutils.c                      |  5 +++--
 keyutils.h                      |  8 ++++----
 man/keyctl.1                    |  2 +-
 man/keyctl_dh_compute.3         | 20 ++++++++++++++------
 man/keyctl_instantiate.3        |  2 +-
 man/keyctl_set_reqkey_keyring.3 |  3 +++
 request-key.c                   |  2 +-
 10 files changed, 33 insertions(+), 21 deletions(-)

Range-diff against v1:
1:  38e9b6c ! 1:  d28b16c keyctl: fix error path message names
    @@ -5,6 +5,15 @@
      diff --git a/keyctl.c b/keyctl.c
      --- a/keyctl.c
      +++ b/keyctl.c
    +@@
    + 	/* get key description */
    + 	ret = keyctl_describe_alloc(key, &buffer);
    + 	if (ret < 0)
    +-		error("keyctl_describe");
    ++		error("keyctl_describe_alloc");
    + 
    + 	/* parse it */
    + 	uid = 0;
     @@
      	ret = keyctl_dh_compute_kdf(private, prime, base, argv[5], NULL,  0,
      				    buffer, buflen);
2:  b96ba41 ! 2:  26b0f98 man/keyctl_dh_compute: mention /proc/crypto for hashnames
    @@ -1,6 +1,6 @@
     Author: Ben Boeckel <mathstuf@gmail.com>
     
    -    man/keyctl_dh_compute: mention /proc/crypto for hashnames
    +    keyctl_dh_compute.3: mention /proc/crypto for hashnames
     
         The kernel does not have a set of known hashnames available. Instead,
         /proc/crypto contains the information for the running system.
3:  9e7ade9 ! 3:  9bd3a31 man/keyctl_dh_compute: clarify keyctl_dh_compute_kdf
    @@ -1,6 +1,6 @@
     Author: Ben Boeckel <mathstuf@gmail.com>
     
    -    man/keyctl_dh_compute: clarify keyctl_dh_compute_kdf
    +    keyctl_dh_compute.3: clarify keyctl_dh_compute_kdf
     
      diff --git a/man/keyctl_dh_compute.3 b/man/keyctl_dh_compute.3
      --- a/man/keyctl_dh_compute.3
4:  36aede7 ! 4:  553ab6a keyctl_dh_compute_kdf: const-ify input parameters
    @@ -32,6 +32,17 @@
      	uint32_t otherinfolen;
      	uint32_t __spare[8];
      };
    +@@
    + extern long keyctl_dh_compute(key_serial_t priv, key_serial_t prime,
    + 			      key_serial_t base, char *buffer, size_t buflen);
    + extern long keyctl_dh_compute_kdf(key_serial_t private, key_serial_t prime,
    +-				  key_serial_t base, char *hashname,
    +-				  char *otherinfo, size_t otherinfolen,
    ++				  key_serial_t base, const char *hashname,
    ++				  const char *otherinfo, size_t otherinfolen,
    + 				  char *buffer, size_t buflen);
    + extern long keyctl_restrict_keyring(key_serial_t keyring, const char *type,
    + 				    const char *restriction);
     
      diff --git a/man/keyctl_dh_compute.3 b/man/keyctl_dh_compute.3
      --- a/man/keyctl_dh_compute.3
5:  8b10e11 ! 5:  d220293 keyctl_dh_compute_kdf: use a void* for opaque data
    @@ -30,9 +30,9 @@
     @@
      			      key_serial_t base, char *buffer, size_t buflen);
      extern long keyctl_dh_compute_kdf(key_serial_t private, key_serial_t prime,
    - 				  key_serial_t base, char *hashname,
    --				  char *otherinfo, size_t otherinfolen,
    -+				  void *otherinfo, size_t otherinfolen,
    + 				  key_serial_t base, const char *hashname,
    +-				  const char *otherinfo, size_t otherinfolen,
    ++				  const void *otherinfo, size_t otherinfolen,
      				  char *buffer, size_t buflen);
      extern long keyctl_restrict_keyring(key_serial_t keyring, const char *type,
      				    const char *restriction);
-:  ------- > 6:  ffdbb78 keyctl_set_reqkey_keyring.3: mention KEY_REQKEY_DEFL_USER_SESSION_KEYRING
-:  ------- > 7:  9e6ae98 typos: fix various typos
-- 
2.19.0.221.g150f307afc
