From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Tue, 03 Oct 2017 16:08:28 +0000
Subject: Re: [PATCH 1/3] crypto: dh_helper - return unsigned int for dh_data_size()
Message-Id: <e1fd27df-69eb-7516-ebac-862fd580bc6a@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170929092106.24276-1-tudor.ambarus@microchip.com>
 <22466.1507021562@warthog.procyon.org.uk>
In-Reply-To: <22466.1507021562@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org

Hi, David,

On 10/03/2017 12:06 PM, David Howells wrote:
> Tudor Ambarus <tudor.ambarus@microchip.com> wrote:
> 
>> -static inline int dh_data_size(const struct dh *p)
>> +static inline unsigned int dh_data_size(const struct dh *p)
>>   {
>>   	return p->key_size + p->p_size + p->g_size;
>>   }
> 
> If this is a problem, do you need to do range checking?

The algorithm does not impose any constraint in this direction, as far
as I'm aware of.

It's unnatural to return a signed integer in a function which just sums
unsigned integers. No checking is needed, the function should return the
unsigned result.

Cheers,
ta
