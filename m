Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC57334F24E;
	Mon,  3 Aug 2026 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772959; cv=none; b=sPdnGVQLz15FsH4LLLx9CvHaEhzGHYSsuFDQTFWfcCQ+/wIHkKt+x6gHh79bHnS4xxeZx0AyIUedsDPULWeV6gbKawMYBLhpkQrdEElIwHgA4vuPCnJHEofUzjIc6T33QMGk1qOYRKangLPKWbVbAFV/IWrJtNPt1becWdBjPNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772959; c=relaxed/simple;
	bh=N96wF4XNaIaQtJGZdj2TvPBJLxAlZaNMmeSkxEfxJyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmTNbiY2375zSCsVLMFU7f/eYKntF4pcbnS22CwQZ2JrQG5bRxIDbQSyMm1OnKlZYMPTfHXQEJjSJqtbvvWA7col7HMX6MwKUBqDDXc7AGbv1K8g3n6r90yKDqpqP4JO+MYk1Thv5DJjO4B4vrApTVKyr6LTTUH1JuBs92pay40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZylOpHM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZylOpHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EF91F00A3A;
	Mon,  3 Aug 2026 16:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785772957;
	bh=SbqQLr7YJqJFe6LXMewN3oPY0av70bdVVJ1dwv14AyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WZylOpHM8yKebEXGwxuFVd7YEmFZgJTN9QntJmmp/4NbR73V1iMhL2LAGpa4h9UA/
	 l779JvEZOfp1Opy1WnsvsKbgS4IDUp7UjVN2e6zzXmM5ZlHjudJd1Fizwu8jSEO5z0
	 rUXgGzbmXMrRQ1bVoGyeGVQljwaFxyxfym3zs0F9k0mRjyOcXn6KZgVS/CvAeETuDp
	 Ln8TXvrFSK6KohNMuB+utJQI5M4WPZsjTXYRSRkr7Wjo2dp78Jg4QATihM6hKLpOh7
	 0wni5e1j+lhGm1Qm2EWPgXMno+rgnLHg4YUVI1HeJpiPwr1qPL+ZIWuPnv42cY+Dng
	 PyxtcHYFe8zZw==
From: Simon Horman <horms@kernel.org>
To: dhowells@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	marc.dionne@auristor.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jaltman@auristor.com,
	jarkko@kernel.org,
	keyrings@vger.kernel.org,
	stable@kernel.org
Subject: Re: [PATCH net v5 02/10] rxrpc: Fix packet encryption error handling
Date: Mon,  3 Aug 2026 17:02:24 +0100
Message-ID: <20260803160224.431797-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729160108.2031453-3-dhowells@redhat.com>
References: <20260729160108.2031453-3-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260729160108.2031453-2-dhowells@redhat.com?part=2
---
--- Patch [2]: [PATCH net v5 02/10] rxrpc: Fix packet encryption error handling ---
commit 59ddcd5fc94e6b2d9346d2e5e32c548184c0070b
Author: David Howells <dhowells@redhat.com>

rxrpc: Fix packet encryption error handling

This commit changes the error handling in rxrpc_send_data() when
secure_packet() fails. It adds logic to rewind the buffer by one byte on
retryable -ENOMEM errors and sets a new RXRPC_CALL_TX_ERROR flag for terminal
errors to prevent further sends.

Closes: https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com

> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> index 4c754f78ece9a..d117a25b031dd 100644
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c
> @@ -330,12 +330,18 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  	bool more = msg->msg_flags & MSG_MORE;
>  	int ret, copied = 0;
>  
> -	if (test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags)) {
> +	if (unlikely(test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags))) {
>  		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
>  				  call->cid, call->call_id, call->rx_consumed,
>  				  0, -EPROTO);
>  		return -EPROTO;
>  	}
> +	if (unlikely(test_bit(RXRPC_CALL_TX_ERROR, &call->flags))) {
> +		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_tx_error,
> +				  call->cid, call->call_id, call->rx_consumed,
> +				  0, -EIO);
> +		return -EIO;
> +	}

[Severity: High]
Does this check get bypassed after waiting for transmit space?

If the transmit window is full, rxrpc_send_data() jumps to wait_for_space
where it drops call->user_mutex and sleeps:

	ret = rxrpc_wait_for_tx_window(rx, call, &timeo,
				       msg->msg_flags & MSG_WAITALL);
    ...
	if (call->interruptibility == RXRPC_INTERRUPTIBLE) {
    ...
	} else {
		mutex_lock(&call->user_mutex);
	}
	goto reload;

When it reacquires the lock, it jumps to the reload label, which is located
after the RXRPC_CALL_TX_ERROR check.

If another thread encounters a terminal crypto error during the lock-drop
window and sets RXRPC_CALL_TX_ERROR, won't this thread blindly reuse the
corrupted call->tx_pending buffer when it wakes up?

[ ... ]

> @@ -440,12 +446,21 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  		/* add the packet to the send queue if it's now full */
>  		if (!txb->space ||
>  		    (msg_data_left(msg) == 0 && !more)) {
> -			if (msg_data_left(msg) == 0 && !more)
> -				txb->flags |= RXRPC_LAST_PACKET;
> -
> +			/* Do any required crypto.  If this fails, it could
> +			 * have corrupted the txbuf content with a partial
> +			 * encrypt.  Assume that ENOMEM is retryable, but
> +			 * everything else is terminal.
> +			 */
>  			ret = call->security->secure_packet(call, txb);
> -			if (ret < 0)
> +			if (ret < 0) {
> +				if (ret == -ENOMEM)
> +					goto maybe_error_rewind;

[ ... ]

> @@ -463,6 +478,20 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  	_leave(" = %d", call->error);
>  	return call->error;
>  
> +maybe_error_rewind:
> +	/* If we got a retryable error after copying all the supplied data into
> +	 * the last packet, we need to rewind the buffer by one byte so the
> +	 * caller knows they need to retry.
> +	 */
> +	if (copied && !more && !msg_data_left(msg)) {
> +		txb->space  += 1;
> +		txb->len    -= 1;
> +		txb->offset -= 1;
> +		copied      -= 1;
> +		if (call->tx_total_len != -1)
> +			call->tx_total_len += 1;
> +		iov_iter_revert(&msg->msg_iter, 1);
> +	}
>  maybe_error:

[Severity: High]
Does this error path drop the -ENOMEM error code and incorrectly return
success?

When secure_packet() fails with -ENOMEM on the final packet, it jumps to
maybe_error_rewind, and falls through to maybe_error.

If data was copied prior to the failure (copied > 0), maybe_error jumps
to success:

maybe_error:
	if (copied) {
		if (rxrpc_call_is_complete(call) &&
		    call->error < 0) {
			ret = call->error;
			goto out_txb;
		}
		goto success;
	}

Will this cause kernel callers like AFS (which use MSG_WAITALL) to see a
positive return value, assume the send succeeded, and hang forever waiting
for a server reply that will never arrive because the final packet was
dropped?

>  	if (copied) {
>  		if (rxrpc_call_is_complete(call) &&
>  		    call->error < 0) {
