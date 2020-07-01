From: Luis Chamberlain <mcgrof@kernel.org>
Date: Wed, 01 Jul 2020 12:20:30 +0000
Subject: Re: INFO: task hung in request_key_tag
Message-Id: <20200701122030.GP4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <000000000000961dea05a95c9558@google.com>
 <728915db-592b-997f-6970-464cc59441d7@i-love.sakura.ne.jp>
In-Reply-To: <728915db-592b-997f-6970-464cc59441d7@i-love.sakura.ne.jp>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, Herbert Xu <herbert@gondor.apana.org.au>, Christoph Hellwig <hch@infradead.org>, mcgrof@kernel.org
Cc: syzbot <syzbot+46c77dc7e98c732de754@syzkaller.appspotmail.com>, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, serge@hallyn.com, syzkaller-bugs@googlegroups.com

On Wed, Jul 01, 2020 at 07:04:15PM +0900, Tetsuo Handa wrote:
> I suspect commit 9e9b47d6bbe9df65 ("umh: fix processed error when UMH_WAI=
T_PROC is used").
> Maybe the change in kernel/umh.c and/or security/keys/request_key.c made =
by that commit is
> affecting call_usermodehelper_keys() =3D 0 case when complete_request_key=
() is called.

That patch has been dropped for now due to another reported issue
bisected to it and even though we have not root caused that issue [0].

It would be good to have a reproducer for this reported issue as well,
but I should also point out a regression which Naresh reported is fixed
recently by a posted patch [1] by Herbert Xu. It would be good if you
can test with that patch posted by Herbert.

[0] https://lkml.kernel.org/r/20200623141157.5409-1-borntraeger@de.ibm.com =
        =20
[1] https://lkml.kernel.org/r/20200626062948.GA25285@gondor.apana.org.au

  Luis

>=20
> On 2020/07/01 16:53, syzbot wrote:
> > Hello,
> >=20
> > syzbot found the following crash on:
> >=20
> > HEAD commit:    c28e58ee Add linux-next specific files for 20200629
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17925a9d100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=DCd26bbca17dd=
1db
> > dashboard link: https://syzkaller.appspot.com/bug?extidFc77dc7e98c732de=
754
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> >=20
> > Unfortunately, I don't have any reproducer for this crash yet.
> >=20
> > IMPORTANT: if you fix the bug, please add the following tag to the comm=
it:
> > Reported-by: syzbot+46c77dc7e98c732de754@syzkaller.appspotmail.com
