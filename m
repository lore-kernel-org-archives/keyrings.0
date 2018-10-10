From: "Williams, Dan J" <dan.j.williams@intel.com>
Date: Wed, 10 Oct 2018 01:35:27 +0000
Subject: Re: [PATCH v12 00/12] Adding security support for nvdimm
Message-Id: <a21c65b315bcfe2bed7bf6d2de99076a41043df0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153904272246.60070.6230977215877367778.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153904272246.60070.6230977215877367778.stgit@djiang5-desk3.ch.intel.com>
To: "Jiang, Dave" <dave.jiang@intel.com>
Cc: "Schofield, Alison" <alison.schofield@intel.com>, "keescook@chromium.org" <keescook@chromium.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "ebiggers3@gmail.com" <ebiggers3@gmail.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>

On Mon, 2018-10-08 at 16:55 -0700, Dave Jiang wrote:
+AD4- The following series implements security support for nvdimm. Mostly
+AD4- adding
+AD4- new security DSM support from the Intel NVDIMM DSM spec v1.7, but
+AD4- also
+AD4- adding generic support libnvdimm for other vendors. The most
+AD4- important
+AD4- security features are unlocking locked nvdimms, and updating/setting
+AD4- security
+AD4- passphrase to nvdimms.
+AD4- 
+AD4- v12:
+AD4- - Add a mutex for the cached key and remove key+AF8-get/key+AF8-put messiness
+AD4- (Dan)
+AD4- - Move security code to its own C file and wrap under
+AD4- CONFIG+AF8-NVDIMM+AF8-SECURITY
+AD4-   in order to fix issue reported by 0-day build without CONFIG+AF8-KEYS.

Going over this a bit more closely here is some proposed cleanups /
fixes:

+ACo- remove nvdimm+AF8-get+AF8-key() and just rely on nvdimm-+AD4-key being not NULL
under the key+AF8-mutex

+ACo- open code nvdimm+AF8-check+AF8-key+AF8-len() checks

+ACo- make all the security op function signatures take an nvdimm rather
than a dev

+ACo- move the release of nvdimm-+AD4-key to nvdimm+AF8-remove() rather than
nvdimm+AF8-release(), i.e. driver unload vs nvdimm+AF8-bus de-registration.

+ACo- rename nvdimm+AF8-replace+AF8-key to make+AF8-kernel+AF8-key

+ACo- clean up nvdimm+AF8-security+AF8-change+AF8-key() to a be bit more readable and
fix a missing key+AF8-put()


Let me know if these look acceptable and I can fold them into the patch
set.

diff --git a/drivers/nvdimm/dimm.c b/drivers/nvdimm/dimm.c
index b6381ddbd6c1..429c544e7ac5 100644
--- a/drivers/nvdimm/dimm.c
+-+-+- b/drivers/nvdimm/dimm.c
+AEAAQA- -23,6 +-23,7 +AEAAQA-
 
 static int nvdimm+AF8-probe(struct device +ACo-dev)
 +AHs-
+-	struct nvdimm +ACo-nvdimm +AD0- to+AF8-nvdimm(dev)+ADs-
 	struct nvdimm+AF8-drvdata +ACo-ndd+ADs-
 	int rc+ADs-
 
+AEAAQA- -51,10 +-52,10 +AEAAQA- static int nvdimm+AF8-probe(struct device +ACo-dev)
 	get+AF8-device(dev)+ADs-
 	kref+AF8-init(+ACY-ndd-+AD4-kref)+ADs-
 
-	nvdimm+AF8-security+AF8-get+AF8-state(dev)+ADs-
+-	nvdimm+AF8-security+AF8-get+AF8-state(nvdimm)+ADs-
 
 	/+ACo- unlock DIMM here before touch label +ACo-/
-	rc +AD0- nvdimm+AF8-security+AF8-unlock+AF8-dimm(dev)+ADs-
+-	rc +AD0- nvdimm+AF8-security+AF8-unlock+AF8-dimm(nvdimm)+ADs-
 	if (rc +ADw- 0)
 		dev+AF8-warn(dev, +ACI-failed to unlock dimm +ACU-s+AFw-n+ACI-, dev+AF8-name(dev))+ADs-
 
+AEAAQA- -115,6 +-116,9 +AEAAQA- static int nvdimm+AF8-probe(struct device +ACo-dev)
 static int nvdimm+AF8-remove(struct device +ACo-dev)
 +AHs-
 	struct nvdimm+AF8-drvdata +ACo-ndd +AD0- dev+AF8-get+AF8-drvdata(dev)+ADs-
+-	struct nvdimm +ACo-nvdimm +AD0- to+AF8-nvdimm(dev)+ADs-
+-
+-	nvdimm+AF8-security+AF8-release(nvdimm)+ADs-
 
 	if (+ACE-ndd)
 		return 0+ADs-
diff --git a/drivers/nvdimm/dimm+AF8-devs.c b/drivers/nvdimm/dimm+AF8-devs.c
index 2d9915378bbc..84bec3bb025e 100644
--- a/drivers/nvdimm/dimm+AF8-devs.c
+-+-+- b/drivers/nvdimm/dimm+AF8-devs.c
+AEAAQA- -213,13 +-213,7 +AEAAQA- void nvdimm+AF8-clear+AF8-locked(struct device +ACo-dev)
 static void nvdimm+AF8-release(struct device +ACo-dev)
 +AHs-
 	struct nvdimm +ACo-nvdimm +AD0- to+AF8-nvdimm(dev)+ADs-
-	struct key +ACo-key+ADs-
 
-	mutex+AF8-lock(+ACY-nvdimm-+AD4-key+AF8-mutex)+ADs-
-	key +AD0- nvdimm+AF8-get+AF8-key(dev)+ADs-
-	if (key)
-		key+AF8-put(key)+ADs-
-	mutex+AF8-unlock(+ACY-nvdimm-+AD4-key+AF8-mutex)+ADs-
 	ida+AF8-simple+AF8-remove(+ACY-dimm+AF8-ida, nvdimm-+AD4-id)+ADs-
 	kfree(nvdimm)+ADs-
 +AH0-
+AEAAQA- -436,20 +-430,20 +AEAAQA- static ssize+AF8-t security+AF8-store(struct device +ACo-dev,
 		if (rc +ACEAPQ- 3)
 			return -EINVAL+ADs-
 		dev+AF8-dbg(dev, +ACI-update +ACUAIw-x +ACUAIw-x+AFw-n+ACI-, old+AF8-key, new+AF8-key)+ADs-
-		rc +AD0- nvdimm+AF8-security+AF8-change+AF8-key(dev, old+AF8-key, new+AF8-key)+ADs-
+-		rc +AD0- nvdimm+AF8-security+AF8-change+AF8-key(nvdimm, old+AF8-key, new+AF8-key)+ADs-
 	+AH0- else if (sysfs+AF8-streq(cmd, +ACI-disable+ACI-)) +AHs-
 		if (rc +ACEAPQ- 2)
 			return -EINVAL+ADs-
 		dev+AF8-dbg(dev, +ACI-disable +ACUAIw-x+AFw-n+ACI-, old+AF8-key)+ADs-
-		rc +AD0- nvdimm+AF8-security+AF8-disable(dev, old+AF8-key)+ADs-
+-		rc +AD0- nvdimm+AF8-security+AF8-disable(nvdimm, old+AF8-key)+ADs-
 	+AH0- else if (sysfs+AF8-streq(buf, +ACI-freeze+ACI-)) +AHs-
 		dev+AF8-dbg(dev, +ACI-freeze+AFw-n+ACI-)+ADs-
-		rc +AD0- nvdimm+AF8-security+AF8-freeze+AF8-lock(dev)+ADs-
+-		rc +AD0- nvdimm+AF8-security+AF8-freeze+AF8-lock(nvdimm)+ADs-
 	+AH0- else if (sysfs+AF8-streq(cmd, +ACI-erase+ACI-)) +AHs-
 		if (rc +ACEAPQ- 2)
 			return -EINVAL+ADs-
 		dev+AF8-dbg(dev, +ACI-erase +ACUAIw-x+AFw-n+ACI-, old+AF8-key)+ADs-
-		rc +AD0- nvdimm+AF8-security+AF8-erase(dev, old+AF8-key)+ADs-
+-		rc +AD0- nvdimm+AF8-security+AF8-erase(nvdimm, old+AF8-key)+ADs-
 	+AH0- else
 		return -EINVAL+ADs-
 
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 08e442632a2d..45fcaf45ba2c 100644
--- a/drivers/nvdimm/nd.h
+-+-+- b/drivers/nvdimm/nd.h
+AEAAQA- -425,48 +-425,47 +AEAAQA- const u8 +ACo-nd+AF8-dev+AF8-to+AF8-uuid(struct device +ACo-dev)+ADs-
 bool pmem+AF8-should+AF8-map+AF8-pages(struct device +ACo-dev)+ADs-
 
 +ACM-ifdef CONFIG+AF8-NVDIMM+AF8-SECURITY
-struct key +ACo-nvdimm+AF8-get+AF8-key(struct device +ACo-dev)+ADs-
-int nvdimm+AF8-security+AF8-unlock+AF8-dimm(struct device +ACo-dev)+ADs-
-int nvdimm+AF8-security+AF8-get+AF8-state(struct device +ACo-dev)+ADs-
-int nvdimm+AF8-security+AF8-change+AF8-key(struct device +ACo-dev, unsigned int old+AF8-keyid,
+-int nvdimm+AF8-security+AF8-unlock+AF8-dimm(struct nvdimm +ACo-nvdimm)+ADs-
+-void nvdimm+AF8-security+AF8-release(struct nvdimm +ACo-nvdimm)+ADs-
+-int nvdimm+AF8-security+AF8-get+AF8-state(struct nvdimm +ACo-nvdimm)+ADs-
+-int nvdimm+AF8-security+AF8-change+AF8-key(struct nvdimm +ACo-nvdimm, unsigned int old+AF8-keyid,
 		unsigned int new+AF8-keyid)+ADs-
-int nvdimm+AF8-security+AF8-disable(struct device +ACo-dev, unsigned int keyid)+ADs-
-int nvdimm+AF8-security+AF8-freeze+AF8-lock(struct device +ACo-dev)+ADs-
-int nvdimm+AF8-security+AF8-erase(struct device +ACo-dev, unsigned int keyid)+ADs-
+-int nvdimm+AF8-security+AF8-disable(struct nvdimm +ACo-nvdimm, unsigned int keyid)+ADs-
+-int nvdimm+AF8-security+AF8-freeze+AF8-lock(struct nvdimm +ACo-nvdimm)+ADs-
+-int nvdimm+AF8-security+AF8-erase(struct nvdimm +ACo-nvdimm, unsigned int keyid)+ADs-
 +ACM-else
-static inline struct key +ACo-nvdimm+AF8-get+AF8-key(struct device +ACo-dev)
+-static inline int nvdimm+AF8-security+AF8-unlock+AF8-dimm(struct nvdimm +ACo-nvdimm)
 +AHs-
-	return NULL+ADs-
+-	return 0+ADs-
 +AH0-
 
-static inline int nvdimm+AF8-security+AF8-unlock+AF8-dimm(struct device +ACo-dev)
+-static inline void nvdimm+AF8-security+AF8-release(struct nvdimm +ACo-nvdimm)
 +AHs-
-	return 0+ADs-
 +AH0-
 
-static inline int nvdimm+AF8-security+AF8-get+AF8-state(struct device +ACo-dev)
+-static inline int nvdimm+AF8-security+AF8-get+AF8-state(struct nvdimm +ACo-nvdimm)
 +AHs-
 	return -EOPNOTSUPP+ADs-
 +AH0-
 
-static inline int nvdimm+AF8-security+AF8-change+AF8-key(struct device +ACo-dev,
+-static inline int nvdimm+AF8-security+AF8-change+AF8-key(struct nvdimm +ACo-nvdimm,
 		unsigned int old+AF8-keyid, unsigned int new+AF8-keyid)
 +AHs-
 	return -EOPNOTSUPP+ADs-
 +AH0-
 
-static inline int nvdimm+AF8-security+AF8-disable(struct device +ACo-dev,
+-static inline int nvdimm+AF8-security+AF8-disable(struct nvdimm +ACo-nvdimm,
 		unsigned int keyid)
 +AHs-
 	return -EOPNOTSUPP+ADs-
 +AH0-
 
-static inline int nvdimm+AF8-security+AF8-freeze+AF8-lock(struct device +ACo-dev)
+-static inline int nvdimm+AF8-security+AF8-freeze+AF8-lock(struct nvdimm +ACo-nvdimm)
 +AHs-
 	return -EOPNOTSUPP+ADs-
 +AH0-
 
-static inline int nvdimm+AF8-security+AF8-erase(struct device +ACo-dev,
+-static inline int nvdimm+AF8-security+AF8-erase(struct nvdimm +ACo-nvdimm,
 		unsigned int keyid)
 +AHs-
 	return -EOPNOTSUPP+ADs-
diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 9f468f91263d..776c440a02ef 100644
--- a/drivers/nvdimm/security.c
+-+-+- b/drivers/nvdimm/security.c
+AEAAQA- -13,31 +-13,13 +AEAAQA-
 +ACM-include +ACI-nd-core.h+ACI-
 +ACM-include +ACI-nd.h+ACI-
 
-/+ACo-
- +ACo- Find key that's cached with nvdimm.
- +ACo-/
-struct key +ACo-nvdimm+AF8-get+AF8-key(struct device +ACo-dev)
-+AHs-
-	struct nvdimm +ACo-nvdimm +AD0- to+AF8-nvdimm(dev)+ADs-
-
-	if (+ACE-nvdimm-+AD4-key)
-		return NULL+ADs-
-
-	if (key+AF8-validate(nvdimm-+AD4-key) +ADw- 0)
-		return NULL+ADs-
-
-	dev+AF8-dbg(dev, +ACIAJQ-s: key found: +ACUAIw-x+AFw-n+ACI-, +AF8AXw-func+AF8AXw-,
-			key+AF8-serial(nvdimm-+AD4-key))+ADs-
-	return nvdimm-+AD4-key+ADs-
-+AH0-
-
 /+ACo-
  +ACo- Replacing the user key with a kernel key. The function expects that
  +ACo- we hold the sem for the key passed in. The function will release that
  +ACo- sem when done process. We will also hold the sem for the valid new key
  +ACo- returned.
  +ACo-/
-static struct key +ACo-nvdimm+AF8-replace+AF8-key(struct key +ACo-key)
+-static struct key +ACo-make+AF8-kernel+AF8-key(struct key +ACo-key)
 +AHs-
 	struct key +ACo-new+AF8-key+ADs-
 	struct user+AF8-key+AF8-payload +ACo-payload+ADs-
+AEAAQA- -86,9 +-68,8 +AEAAQA- static struct key +ACo-nvdimm+AF8-lookup+AF8-user+AF8-key(struct device +ACo-dev,
 /+ACo-
  +ACo- Retrieve kernel key for DIMM and request from user space if necessary.
  +ACo-/
-static struct key +ACo-nvdimm+AF8-request+AF8-key(struct device +ACo-dev)
+-static struct key +ACo-nvdimm+AF8-request+AF8-key(struct nvdimm +ACo-nvdimm)
 +AHs-
-	struct nvdimm +ACo-nvdimm +AD0- to+AF8-nvdimm(dev)+ADs-
 	struct key +ACo-key +AD0- NULL+ADs-
 	char desc+AFs-NVDIMM+AF8-KEY+AF8-DESC+AF8-LEN +- sizeof(NVDIMM+AF8-PREFIX)+AF0AOw-
 
+AEAAQA- -100,34 +-81,26 +AEAAQA- static struct key +ACo-nvdimm+AF8-request+AF8-key(struct device +ACo-dev)
 	return key+ADs-
 +AH0-
 
-static int nvdimm+AF8-check+AF8-key+AF8-len(unsigned short len)
-+AHs-
-	if (len +AD0APQ- NVDIMM+AF8-PASSPHRASE+AF8-LEN)
-		return 0+ADs-
-
-	return -EINVAL+ADs-
-+AH0-
-
-struct key +ACo-nvdimm+AF8-get+AF8-and+AF8-verify+AF8-key(struct device +ACo-dev,
+-struct key +ACo-nvdimm+AF8-get+AF8-and+AF8-verify+AF8-key(struct nvdimm +ACo-nvdimm,
 		unsigned int user+AF8-key+AF8-id)
 +AHs-
+-	int rc+ADs-
 	struct key +ACo-user+AF8-key, +ACo-key+ADs-
+-	struct device +ACo-dev +AD0- +ACY-nvdimm-+AD4-dev+ADs-
 	struct user+AF8-key+AF8-payload +ACo-upayload, +ACo-payload+ADs-
-	int rc +AD0- 0+ADs-
 
-	key +AD0- nvdimm+AF8-get+AF8-key(dev)+ADs-
-	/+ACo- we don't have a cached key +ACo-/
+-	lockdep+AF8-assert+AF8-held(+ACY-nvdimm-+AD4-key+AF8-mutex)+ADs-
+-	key +AD0- nvdimm-+AD4-key+ADs-
 	if (+ACE-key) +AHs-
 		dev+AF8-dbg(dev, +ACI-No cached kernel key+AFw-n+ACI-)+ADs-
-		return NULL+ADs-
+-		return ERR+AF8-PTR(-EAGAIN)+ADsAOw-
 	+AH0-
 	dev+AF8-dbg(dev, +ACI-cached+AF8-key: +ACUAIw-x+AFw-n+ACI-, key+AF8-serial(key))+ADs-
 
 	user+AF8-key +AD0- nvdimm+AF8-lookup+AF8-user+AF8-key(dev, user+AF8-key+AF8-id)+ADs-
 	if (+ACE-user+AF8-key) +AHs-
 		dev+AF8-dbg(dev, +ACI-Old user key lookup failed+AFw-n+ACI-)+ADs-
-		rc +AD0- -EINVAL+ADs-
-		goto out+ADs-
+-		return ERR+AF8-PTR(-EINVAL)+ADs-
 	+AH0-
 	dev+AF8-dbg(dev, +ACI-user+AF8-key: +ACUAIw-x+AFw-n+ACI-, key+AF8-serial(user+AF8-key))+ADs-
 
+AEAAQA- -136,45 +-109,38 +AEAAQA- struct key +ACo-nvdimm+AF8-get+AF8-and+AF8-verify+AF8-key(struct device +ACo-dev,
 	payload +AD0- key-+AD4-payload.data+AFs-0+AF0AOw-
 	upayload +AD0- user+AF8-key-+AD4-payload.data+AFs-0+AF0AOw-
 
-	if (memcmp(payload-+AD4-data, upayload-+AD4-data,
-				NVDIMM+AF8-PASSPHRASE+AF8-LEN) +ACEAPQ- 0) +AHs-
-		rc +AD0- -EINVAL+ADs-
-		dev+AF8-warn(dev, +ACI-Supplied old user key fails check.+AFw-n+ACI-)+ADs-
-	+AH0-
-
+-	rc +AD0- memcmp(payload-+AD4-data, upayload-+AD4-data, NVDIMM+AF8-PASSPHRASE+AF8-LEN)+ADs-
 	up+AF8-read(+ACY-user+AF8-key-+AD4-sem)+ADs-
 	key+AF8-put(user+AF8-key)+ADs-
 	up+AF8-read(+ACY-key-+AD4-sem)+ADs-
 
-out:
-	if (rc +ADw- 0)
-		key +AD0- ERR+AF8-PTR(rc)+ADs-
+-	if (rc +ACEAPQ- 0) +AHs-
+-		dev+AF8-warn(dev, +ACI-Supplied old user key fails check.+AFw-n+ACI-)+ADs-
+-		return ERR+AF8-PTR(-EINVAL)+ADs-
+-	+AH0-
 	return key+ADs-
 +AH0-
 
-int nvdimm+AF8-security+AF8-get+AF8-state(struct device +ACo-dev)
+-int nvdimm+AF8-security+AF8-get+AF8-state(struct nvdimm +ACo-nvdimm)
 +AHs-
-	struct nvdimm +ACo-nvdimm +AD0- to+AF8-nvdimm(dev)+ADs-
-
 	if (+ACE-nvdimm-+AD4-security+AF8-ops)
 		return 0+ADs-
 
 	return nvdimm-+AD4-security+AF8-ops-+AD4-state(nvdimm, +ACY-nvdimm-+AD4-state)+ADs-
 +AH0-
 
-int nvdimm+AF8-security+AF8-erase(struct device +ACo-dev, unsigned int keyid)
+-int nvdimm+AF8-security+AF8-erase(struct nvdimm +ACo-nvdimm, unsigned int keyid)
 +AHs-
-	struct nvdimm +ACo-nvdimm +AD0- to+AF8-nvdimm(dev)+ADs-
-	struct nvdimm+AF8-bus +ACo-nvdimm+AF8-bus +AD0- walk+AF8-to+AF8-nvdimm+AF8-bus(dev)+ADs-
+-	int rc +AD0- 0+ADs-
 	struct key +ACo-key+ADs-
 	struct user+AF8-key+AF8-payload +ACo-payload+ADs-
-	int rc +AD0- 0+ADs-
+-	struct device +ACo-dev +AD0- +ACY-nvdimm-+AD4-dev+ADs-
 	bool is+AF8-userkey +AD0- false+ADs-
 
 	if (+ACE-nvdimm-+AD4-security+AF8-ops)
 		return -EOPNOTSUPP+ADs-
 
-	nvdimm+AF8-bus+AF8-lock(+ACY-nvdimm+AF8-bus-+AD4-dev)+ADs-
+-	nvdimm+AF8-bus+AF8-lock(dev)+ADs-
 	mutex+AF8-lock(+ACY-nvdimm-+AD4-key+AF8-mutex)+ADs-
 	if (atomic+AF8-read(+ACY-nvdimm-+AD4-busy)) +AHs-
 		dev+AF8-warn(dev, +ACI-Unable to secure erase while DIMM active.+AFw-n+ACI-)+ADs-
+AEAAQA- -195,7 +-161,7 +AEAAQA- int nvdimm+AF8-security+AF8-erase(struct device +ACo-dev, unsigned int keyid)
 	+AH0-
 
 	/+ACo- look for a key from cached key if exists +ACo-/
-	key +AD0- nvdimm+AF8-get+AF8-and+AF8-verify+AF8-key(dev, keyid)+ADs-
+-	key +AD0- nvdimm+AF8-get+AF8-and+AF8-verify+AF8-key(nvdimm, keyid)+ADs-
 	if (IS+AF8-ERR(key)) +AHs-
 		dev+AF8-dbg(dev, +ACI-Unable to get and verify key+AFw-n+ACI-)+ADs-
 		rc +AD0- PTR+AF8-ERR(key)+ADs-
+AEAAQA- -229,14 +-195,13 +AEAAQA- int nvdimm+AF8-security+AF8-erase(struct device +ACo-dev, unsigned int keyid)
 
  out:
 	mutex+AF8-unlock(+ACY-nvdimm-+AD4-key+AF8-mutex)+ADs-
-	nvdimm+AF8-bus+AF8-unlock(+ACY-nvdimm+AF8-bus-+AD4-dev)+ADs-
-	nvdimm+AF8-security+AF8-get+AF8-state(dev)+ADs-
+-	nvdimm+AF8-bus+AF8-unlock(dev)+ADs-
+-	nvdimm+AF8-security+AF8-get+AF8-state(nvdimm)+ADs-
 	return rc+ADs-
 +AH0-
 
-int nvdimm+AF8-security+AF8-freeze+AF8-lock(struct device +ACo-dev)
+-int nvdimm+AF8-security+AF8-freeze+AF8-lock(struct nvdimm +ACo-nvdimm)
 +AHs-
-	struct nvdimm +ACo-nvdimm +AD0- to+AF8-nvdimm(dev)+ADs-
 	int rc+ADs-
 
 	if (+ACE-nvdimm-+AD4-security+AF8-ops)
+AEAAQA- -249,16 +-214,16 +AEAAQA- int nvdimm+AF8-security+AF8-freeze+AF8-lock(struct device +ACo-dev)
 	if (rc +ADw- 0)
 		return rc+ADs-
 
-	nvdimm+AF8-security+AF8-get+AF8-state(dev)+ADs-
+-	nvdimm+AF8-security+AF8-get+AF8-state(nvdimm)+ADs-
 	return 0+ADs-
 +AH0-
 
-int nvdimm+AF8-security+AF8-disable(struct device +ACo-dev, unsigned int keyid)
+-int nvdimm+AF8-security+AF8-disable(struct nvdimm +ACo-nvdimm, unsigned int keyid)
 +AHs-
-	struct nvdimm +ACo-nvdimm +AD0- to+AF8-nvdimm(dev)+ADs-
-	struct key +ACo-key+ADs-
 	int rc+ADs-
+-	struct key +ACo-key+ADs-
 	struct user+AF8-key+AF8-payload +ACo-payload+ADs-
+-	struct device +ACo-dev +AD0- +ACY-nvdimm-+AD4-dev+ADs-
 	bool is+AF8-userkey +AD0- false+ADs-
 
 	if (+ACE-nvdimm-+AD4-security+AF8-ops)
+AEAAQA- -269,7 +-234,7 +AEAAQA- int nvdimm+AF8-security+AF8-disable(struct device +ACo-dev, unsigned int keyid)
 
 	mutex+AF8-lock(+ACY-nvdimm-+AD4-key+AF8-mutex)+ADs-
 	/+ACo- look for a key from cached key +ACo-/
-	key +AD0- nvdimm+AF8-get+AF8-and+AF8-verify+AF8-key(dev, keyid)+ADs-
+-	key +AD0- nvdimm+AF8-get+AF8-and+AF8-verify+AF8-key(nvdimm, keyid)+ADs-
 	if (IS+AF8-ERR(key)) +AHs-
 		mutex+AF8-unlock(+ACY-nvdimm-+AD4-key+AF8-mutex)+ADs-
 		return PTR+AF8-ERR(key)+ADs-
+AEAAQA- -304,17 +-269,16 +AEAAQA- int nvdimm+AF8-security+AF8-disable(struct device +ACo-dev, unsigned int keyid)
 
  out:
 	mutex+AF8-unlock(+ACY-nvdimm-+AD4-key+AF8-mutex)+ADs-
-	nvdimm+AF8-security+AF8-get+AF8-state(dev)+ADs-
+-	nvdimm+AF8-security+AF8-get+AF8-state(nvdimm)+ADs-
 	return rc+ADs-
 +AH0-
 
-int nvdimm+AF8-security+AF8-unlock+AF8-dimm(struct device +ACo-dev)
+-int nvdimm+AF8-security+AF8-unlock+AF8-dimm(struct nvdimm +ACo-nvdimm)
 +AHs-
-	struct nvdimm +ACo-nvdimm +AD0- to+AF8-nvdimm(dev)+ADs-
 	struct key +ACo-key+ADs-
+-	int rc +AD0- -ENXIO+ADs-
 	struct user+AF8-key+AF8-payload +ACo-payload+ADs-
-	int rc+ADs-
-	bool cached+AF8-key +AD0- false+ADs-
+-	struct device +ACo-dev +AD0- +ACY-nvdimm-+AD4-dev+ADs-
 
 	if (+ACE-nvdimm-+AD4-security+AF8-ops)
 		return 0+ADs-
+AEAAQA- -325,24 +-289,19 +AEAAQA- int nvdimm+AF8-security+AF8-unlock+AF8-dimm(struct device +ACo-dev)
 		return 0+ADs-
 
 	mutex+AF8-lock(+ACY-nvdimm-+AD4-key+AF8-mutex)+ADs-
-	key +AD0- nvdimm+AF8-get+AF8-key(dev)+ADs-
-	if (+ACE-key)
-		key +AD0- nvdimm+AF8-request+AF8-key(dev)+ADs-
-	else
-		cached+AF8-key +AD0- true+ADs-
+-	key +AD0- nvdimm-+AD4-key+ADs-
 	if (+ACE-key) +AHs-
-		mutex+AF8-unlock(+ACY-nvdimm-+AD4-key+AF8-mutex)+ADs-
-		return -ENXIO+ADs-
-	+AH0-
-
-	if (+ACE-cached+AF8-key) +AHs-
-		rc +AD0- nvdimm+AF8-check+AF8-key+AF8-len(key-+AD4-datalen)+ADs-
-		if (rc +ADw- 0) +AHs-
+-		key +AD0- nvdimm+AF8-request+AF8-key(nvdimm)+ADs-
+-		if (key +ACYAJg- key-+AD4-datalen +ACEAPQ- NVDIMM+AF8-PASSPHRASE+AF8-LEN) +AHs-
 			key+AF8-put(key)+ADs-
-			mutex+AF8-unlock(+ACY-nvdimm-+AD4-key+AF8-mutex)+ADs-
-			return rc+ADs-
+-			key +AD0- NULL+ADs-
+-			rc +AD0- -EINVAL+ADs-
 		+AH0-
 	+AH0-
+-	if (+ACE-key) +AHs-
+-		mutex+AF8-unlock(+ACY-nvdimm-+AD4-key+AF8-mutex)+ADs-
+-		return rc+ADs-
+-	+AH0-
 
 	dev+AF8-dbg(dev, +ACIAJQ-s: key: +ACUAIw-x+AFw-n+ACI-, +AF8AXw-func+AF8AXw-, key+AF8-serial(key))+ADs-
 	down+AF8-read(+ACY-key-+AD4-sem)+ADs-
+AEAAQA- -352,7 +-311,7 +AEAAQA- int nvdimm+AF8-security+AF8-unlock+AF8-dimm(struct device +ACo-dev)
 	up+AF8-read(+ACY-key-+AD4-sem)+ADs-
 
 	if (rc +AD0APQ- 0) +AHs-
-		if (+ACE-cached+AF8-key)
+-		if (+ACE-nvdimm-+AD4-key)
 			nvdimm-+AD4-key +AD0- key+ADs-
 		nvdimm-+AD4-state +AD0- NVDIMM+AF8-SECURITY+AF8-UNLOCKED+ADs-
 		dev+AF8-dbg(dev, +ACI-DIMM +ACU-s unlocked+AFw-n+ACI-, dev+AF8-name(dev))+ADs-
+AEAAQA- -364,18 +-323,31 +AEAAQA- int nvdimm+AF8-security+AF8-unlock+AF8-dimm(struct device +ACo-dev)
 	+AH0-
 
 	mutex+AF8-unlock(+ACY-nvdimm-+AD4-key+AF8-mutex)+ADs-
-	nvdimm+AF8-security+AF8-get+AF8-state(dev)+ADs-
+-	nvdimm+AF8-security+AF8-get+AF8-state(nvdimm)+ADs-
 	return rc+ADs-
 +AH0-
 
-int nvdimm+AF8-security+AF8-change+AF8-key(struct device +ACo-dev,
+-void nvdimm+AF8-security+AF8-release(struct nvdimm +ACo-nvdimm)
+-+AHs-
+-	mutex+AF8-lock(+ACY-nvdimm-+AD4-key+AF8-mutex)+ADs-
+-	key+AF8-put(nvdimm-+AD4-key)+ADs-
+-	nvdimm-+AD4-key +AD0- NULL+ADs-
+-	mutex+AF8-unlock(+ACY-nvdimm-+AD4-key+AF8-mutex)+ADs-
+-+AH0-
+-
+-static void key+AF8-destroy(struct key +ACo-key)
+-+AHs-
+-	key+AF8-invalidate(key)+ADs-
+-	key+AF8-put(key)+ADs-
+-+AH0-
+-
+-int nvdimm+AF8-security+AF8-change+AF8-key(struct nvdimm +ACo-nvdimm,
 		unsigned int old+AF8-keyid, unsigned int new+AF8-keyid)
 +AHs-
-	struct nvdimm +ACo-nvdimm +AD0- to+AF8-nvdimm(dev)+ADs-
-	struct key +ACo-key, +ACo-old+AF8-key+ADs-
 	int rc+ADs-
+-	struct key +ACo-key, +ACo-old+AF8-key+ADs-
 	void +ACo-old+AF8-data +AD0- NULL, +ACo-new+AF8-data+ADs-
-	bool update +AD0- false+ADs-
+-	struct device +ACo-dev +AD0- +ACY-nvdimm-+AD4-dev+ADs-
 	struct user+AF8-key+AF8-payload +ACo-payload, +ACo-old+AF8-payload+ADs-
 
 	if (+ACE-nvdimm-+AD4-security+AF8-ops)
+AEAAQA- -386,16 +-358,15 +AEAAQA- int nvdimm+AF8-security+AF8-change+AF8-key(struct device +ACo-dev,
 
 	mutex+AF8-lock(+ACY-nvdimm-+AD4-key+AF8-mutex)+ADs-
 	/+ACo- look for a key from cached key if exists +ACo-/
-	old+AF8-key +AD0- nvdimm+AF8-get+AF8-and+AF8-verify+AF8-key(dev, old+AF8-keyid)+ADs-
-	if (IS+AF8-ERR(old+AF8-key)) +AHs-
+-	old+AF8-key +AD0- nvdimm+AF8-get+AF8-and+AF8-verify+AF8-key(nvdimm, old+AF8-keyid)+ADs-
+-	if (IS+AF8-ERR(old+AF8-key) +ACYAJg- PTR+AF8-ERR(old+AF8-key) +AD0APQ- -EAGAIN)
+-		old+AF8-key +AD0- NULL+ADs-
+-	else if (IS+AF8-ERR(old+AF8-key)) +AHs-
 		mutex+AF8-unlock(+ACY-nvdimm-+AD4-key+AF8-mutex)+ADs-
 		return PTR+AF8-ERR(old+AF8-key)+ADs-
-	+AH0-
-	if (old+AF8-key) +AHs-
-		dev+AF8-dbg(dev, +ACIAJQ-s: old key: +ACUAIw-x+AFw-n+ACI-,
-				+AF8AXw-func+AF8AXw-, key+AF8-serial(old+AF8-key))+ADs-
-		update +AD0- true+ADs-
-	+AH0-
+-	+AH0- else
+-		dev+AF8-dbg(dev, +ACIAJQ-s: old key: +ACUAIw-x+AFw-n+ACI-, +AF8AXw-func+AF8AXw-,
+-				key+AF8-serial(old+AF8-key))+ADs-
 
 	/+ACo- request new key from userspace +ACo-/
 	key +AD0- nvdimm+AF8-lookup+AF8-user+AF8-key(dev, new+AF8-keyid)+ADs-
+AEAAQA- -409,22 +-380,29 +AEAAQA- int nvdimm+AF8-security+AF8-change+AF8-key(struct device +ACo-dev,
 
 	down+AF8-read(+ACY-key-+AD4-sem)+ADs-
 	payload +AD0- key-+AD4-payload.data+AFs-0+AF0AOw-
-	rc +AD0- nvdimm+AF8-check+AF8-key+AF8-len(payload-+AD4-datalen)+ADs-
-	if (rc +ADw- 0) +AHs-
+-	if (payload-+AD4-datalen +ACEAPQ- NVDIMM+AF8-PASSPHRASE+AF8-LEN) +AHs-
+-		rc +AD0- -EINVAL+ADs-
 		up+AF8-read(+ACY-key-+AD4-sem)+ADs-
 		goto out+ADs-
 	+AH0-
 
-	if (+ACE-update)
-		key +AD0- nvdimm+AF8-replace+AF8-key(key)+ADs-
+-	/+ACo-
+-	 +ACo- Since there is no existing key this user key will become the
+-	 +ACo- kernel's key.
+-	 +ACo-/
+-	if (+ACE-old+AF8-key) +AHs-
+-		key +AD0- make+AF8-kernel+AF8-key(key)+ADs-
+-		if (+ACE-key) +AHs-
+-			rc +AD0- -ENOMEM+ADs-
+-			goto out+ADs-
+-		+AH0-
+-	+AH0-
 
 	/+ACo-
 	 +ACo- We don't need to release key-+AD4-sem here because
-	 +ACo- nvdimm+AF8-replace+AF8-key() will.
+-	 +ACo- make+AF8-kernel+AF8-key() will have upgraded the user key to kernel
+-	 +ACo- and handled the semaphore handoff.
 	 +ACo-/
-	if (+ACE-key)
-		goto out+ADs-
-
 	payload +AD0- key-+AD4-payload.data+AFs-0+AF0AOw-
 
 	if (old+AF8-key) +AHs-
+AEAAQA- -437,25 +-415,26 +AEAAQA- int nvdimm+AF8-security+AF8-change+AF8-key(struct device +ACo-dev,
 
 	rc +AD0- nvdimm-+AD4-security+AF8-ops-+AD4-change+AF8-key(nvdimm, old+AF8-data,
 			new+AF8-data)+ADs-
-	/+ACo- copy new payload to old payload +ACo-/
-	if (rc +AD0APQ- 0) +AHs-
-		if (update)
+-	if (rc)
+-		dev+AF8-warn(dev, +ACI-key update failed: +ACU-d+AFw-n+ACI-, rc)+ADs-
+-
+-	if (old+AF8-key) +AHs-
+-		/+ACo- copy new payload to old payload +ACo-/
+-		if (rc +AD0APQ- 0)
 			key+AF8-update(make+AF8-key+AF8-ref(old+AF8-key, 1), new+AF8-data,
 					old+AF8-key-+AD4-datalen)+ADs-
-	+AH0- else
-		dev+AF8-warn(dev, +ACI-key update failed+AFw-n+ACI-)+ADs-
-	if (old+AF8-key)
 		up+AF8-read(+ACY-old+AF8-key-+AD4-sem)+ADs-
+-	+AH0-
 	up+AF8-read(+ACY-key-+AD4-sem)+ADs-
 
-	if (+ACE-update) +AHs-
+-	if (+ACE-old+AF8-key) +AHs-
 		if (rc +AD0APQ- 0) +AHs-
 			dev+AF8-dbg(dev, +ACI-key cached: +ACUAIw-x+AFw-n+ACI-, key+AF8-serial(key))+ADs-
 			nvdimm-+AD4-key +AD0- key+ADs-
 		+AH0- else
-			key+AF8-invalidate(key)+ADs-
+-			key+AF8-destroy(key)+ADs-
 	+AH0-
-	nvdimm+AF8-security+AF8-get+AF8-state(dev)+ADs-
+-	nvdimm+AF8-security+AF8-get+AF8-state(nvdimm)+ADs-
 
  out:
 	mutex+AF8-unlock(+ACY-nvdimm-+AD4-key+AF8-mutex)+ADs-
