Return-Path: <keyrings-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFECC0032E
	for <keyrings@archiver.kernel.org>; Wed, 25 Oct 2023 17:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjJYRgN (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Wed, 25 Oct 2023 13:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbjJYRgC (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Wed, 25 Oct 2023 13:36:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8D6183;
        Wed, 25 Oct 2023 10:36:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3551DC433C8;
        Wed, 25 Oct 2023 17:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698255359;
        bh=76zTKwswmBirf1LCqHxQmnoZ+6FzNZDOXE/gwyujFsM=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=lj+Ip072aXzpoqSgPyMhTHwAuLFysevZmOBAkVx+ZMK32rMbctOB7YPlz6oRtA03Z
         8ppvmdIo6hyxLCIfUvvmJNKOTxyLIKOdf+42c6zSVzjKetK0JYlDSuFleOSKfbqQ8D
         vxklxPt/SCMuhC27qPxyKNHB1eRkdTZGlzFr39OheOmwtnOFcxWxAFmiVSNiP4ZV6j
         3IjftZ2yz/lkmkGuaKimR5kmtsJDYaVJigdbpshaFaiEzap1h6eodxqq/gk8N3hrC8
         8BuiBgQzMWV08SM9MB9JtYWCjYYebLFT5FAe587OskyVpLphNWtvtcc3EJ5VuF0XXa
         8FVxtfbgdabhA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 25 Oct 2023 20:35:55 +0300
Message-Id: <CWHPA3T3YIJT.148L3L98EXBXD@suppilovahvero>
Cc:     <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
        "James Bottomley" <James.Bottomley@hansenpartnership.com>,
        "William Roberts" <bill.c.roberts@gmail.com>,
        "Stefan Berger" <stefanb@linux.ibm.com>,
        "David Howells" <dhowells@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        "Julien Gomes" <julien@arista.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] tpm: Move buffer handling from static inlines to
 real functions
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jerry Snitselaar" <jsnitsel@redhat.com>
X-Mailer: aerc 0.15.2
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-2-jarkko@kernel.org>
 <qktrbbbqrz3z4jh4h7pz42leikmyg2mdevzl2brapn32kst55e@s5thpstdtlxp>
In-Reply-To: <qktrbbbqrz3z4jh4h7pz42leikmyg2mdevzl2brapn32kst55e@s5thpstdtlxp>
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

On Wed Oct 25, 2023 at 12:03 PM EEST, Jerry Snitselaar wrote:
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

On Wed, 2023-10-25 at 02:03 -0700, Jerry Snitselaar wrote:
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
>

Thanks I'll add it to the next round.

For the tpm_buf_read(), I was thinking along the lines of:

/**
 * tpm_buf_read() - Read from a TPM buffer
 * @buf:	&tpm_buf instance
 * @pos:	position within the buffer
 * @count:	the number of bytes to read
 * @output:	the output buffer
 *
 * Read bytes from a TPM buffer, and update the position. Returns false whe=
n the
 * amount of bytes requested would overflow the buffer, which is expected t=
o
 * only happen in the case of hardware failure.
 */
static bool tpm_buf_read(const struct tpm_buf *buf, off_t *pos, size_t coun=
t, void *output)
{
	off_t next =3D *pos + count;

	if (next >=3D buf->length) {
		pr_warn("%s: %lu >=3D %lu\n", __func__, next, *offset);
		return false;
	}

	memcpy(output, &buf->data[*pos], count);
	*offset =3D next;
	return true;
}

BR, Jarkko




