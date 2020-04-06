From: "J. Bruce Fields" <bfields@fieldses.org>
Date: Mon, 06 Apr 2020 16:07:06 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <20200406160706.GC2147@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <2590640.1585757211@warthog.procyon.org.uk>
 <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
 <20200403111144.GB34663@gardel-login>
 <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
 <20200403151223.GB34800@gardel-login>
 <20200403203024.GB27105@fieldses.org>
 <CAJfpegvxnp8N-o-iTXzj0UnYZbDPfms1zpwcHf1tdhRJ4au3Og@mail.gmail.com>
In-Reply-To: <CAJfpegvxnp8N-o-iTXzj0UnYZbDPfms1zpwcHf1tdhRJ4au3Og@mail.gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Lennart Poettering <mzxreary@0pointer.de>, Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>

The patch makes sense to me, thanks!

In the NFS case it's implementing the "mountpoint" export option:

       mountpoint=3Dpath

       mp     This option makes it possible to only export a directory  if =
 it
              has  successfully  been  mounted.   If  no  path  is given (e=
.g.
              mountpoint or mp) then the export point must  also  be  a  mo=
unt
              point.  If it isn't then the export point is not exported.  T=
his
              allows you to be sure that the directory underneath a mountpo=
int
              will never be exported by accident if, for example, the files=
ys=E2=80=90
              tem failed to mount due to a disc error.

              If a path is given (e.g.  mountpoint=3D/path or mp=3D/path) t=
hen the
              nominated  path  must  be a mountpoint for the exportpoint to=
 be
              exported.

--b.

On Mon, Apr 06, 2020 at 10:35:55AM +0200, Miklos Szeredi wrote:
> From: Miklos Szeredi <mszeredi@redhat.com>
> Subject: statx: add mount_root
>=20
> Determining whether a path or file descriptor refers to a mountpoint (or
> more precisely a mount root) is not trivial using current tools.
>=20
> Add a flag to statx that indicates whether the path or fd refers to the
> root of a mount or not.
>=20
> Reported-by: Lennart Poettering <mzxreary@0pointer.de>
> Reported-by: J. Bruce Fields <bfields@fieldses.org>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/stat.c                 |    3 +++
>  include/uapi/linux/stat.h |    1 +
>  2 files changed, 4 insertions(+)
>=20
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -172,6 +172,7 @@ struct statx {
>  #define STATX_ATTR_NODUMP		0x00000040 /* [I] File is not to be dumped */
>  #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to dec=
rypt in fs */
>  #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
> +#define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
>  #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
> =20
> =20
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -202,6 +202,9 @@ int vfs_statx(int dfd, const char __user
>  	error =3D vfs_getattr(&path, stat, request_mask, flags);
>  	stat->mnt_id =3D real_mount(path.mnt)->mnt_id;
>  	stat->result_mask |=3D STATX_MNT_ID;
> +	if (path.mnt->mnt_root =3D path.dentry)
> +		stat->attributes |=3D STATX_ATTR_MOUNT_ROOT;
> +	stat->attributes_mask |=3D STATX_ATTR_MOUNT_ROOT;
>  	path_put(&path);
>  	if (retry_estale(error, lookup_flags)) {
>  		lookup_flags |=3D LOOKUP_REVAL;
