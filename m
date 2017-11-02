From: David Howells <dhowells@redhat.com>
Date: Thu, 02 Nov 2017 22:29:50 +0000
Subject: Re: [PATCH] KEYS: allow searching of user-session keyring if session keyring exists
Message-Id: <19252.1509661790@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <001f3865-e1ee-410f-07f2-e655c7f59ec9@gmail.com>
In-Reply-To: <001f3865-e1ee-410f-07f2-e655c7f59ec9@gmail.com>
To: keyrings@vger.kernel.org

Marcho <marcho.markov@gmail.com> wrote:

> In search_my_process_keyrings(), if a session keyring exists, we will skip
> the search of a potential user-session keyring.

That is the correct behaviour.

You can fix this in userspace by adding a link into the session keyring that
points to the user-session keyring if you must.  You may have noted that the
search algorithm also does not directly search the user keyring - pam_keyinit
adds the link, thereby explicitly adding the user keyring to the search tree.

You should not be using the user-session keyring like this.  I would recommend
either using the user keyring or the newer persistent keyring.

David
