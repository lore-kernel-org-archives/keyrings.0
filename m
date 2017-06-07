From: Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Wed, 07 Jun 2017 20:52:06 +0000
Subject: Re: [PATCH keyutils] TEST: Add KDF leading zero test
Message-Id: <alpine.OSX.2.21.1706071310570.19308@wchen26-mobl1.amr.corp.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0-116561679-1496868726=:19308"
List-Id: <keyrings.vger.kernel.org>
References: <20170607173135.19912-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20170607173135.19912-1-mathew.j.martineau@linux.intel.com>
To: keyrings@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-116561679-1496868726=:19308
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable


Hi Stephan,

On Wed, 7 Jun 2017, Stephan M=FCller wrote:

> Am Mittwoch, 7. Juni 2017, 19:31:35 CEST schrieb Mat Martineau:
>
> Hi Mat,
>
>> Diffie-Hellman results used as input to a KDF algorithm can have leading
>> zero bytes, and the current kernel DH implementation truncates leading
>> zero bytes. This test confirms that the KDF code correctly handles DH
>> results with leading zeros.
>
> Thank you for the test.
>
> May I ask where you got the vector from?

I had to derive the test vector from the sha256 kdf test vector. There's=20
one CAVP test vector with four leading zero bits, but not a full byte.

I swapped in a '0x01' for the base integer, which creates a shared secret=20
having only the least significant bit set (maximum number of leading=20
zeros). I constructed a binary file (kdf.in) starting with 0x00 0x00 0x00=20
0x01 (for the counter value), followed by 255 0x00's, then 0x01, then the=20
"otherinfo" from the sha256 test case. Then I confirmed that the initial=20
bytes output by `sha256sum kdf.in` matched the keyutils output from the=20
kernel KDF implementation, and used that output as the reference result.

--
Mat Martineau
Intel OTC
--0-116561679-1496868726=:19308--
