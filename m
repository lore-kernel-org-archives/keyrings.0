From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Wed, 01 Jul 2020 10:04:15 +0000
Subject: Re: INFO: task hung in request_key_tag
Message-Id: <728915db-592b-997f-6970-464cc59441d7@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <000000000000961dea05a95c9558@google.com>
In-Reply-To: <000000000000961dea05a95c9558@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: syzbot <syzbot+46c77dc7e98c732de754@syzkaller.appspotmail.com>, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, serge@hallyn.com, syzkaller-bugs@googlegroups.com

I suspect commit 9e9b47d6bbe9df65 ("umh: fix processed error when UMH_WAIT_=
PROC is used").
Maybe the change in kernel/umh.c and/or security/keys/request_key.c made by=
 that commit is
affecting call_usermodehelper_keys() =3D 0 case when complete_request_key()=
 is called.

On 2020/07/01 16:53, syzbot wrote:
> Hello,
>=20
> syzbot found the following crash on:
>=20
> HEAD commit:    c28e58ee Add linux-next specific files for 20200629
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17925a9d100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=DCd26bbca17dd1db
> dashboard link: https://syzkaller.appspot.com/bug?extidFc77dc7e98c732de754
> compiler:       gcc (GCC) 10.1.0-syz 20200507
>=20
> Unfortunately, I don't have any reproducer for this crash yet.
>=20
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+46c77dc7e98c732de754@syzkaller.appspotmail.com
