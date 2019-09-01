From: Yihao Wu <wuyihao@linux.alibaba.com>
Date: Sun, 01 Sep 2019 10:31:56 +0000
Subject: Re: [PATCH 2/2] sign-file: detect existing signature and handle it
Message-Id: <3c825d6a-4dd9-cd77-5af4-9d5af1fef843@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <33691ba1-6427-4439-5aa9-792ec8b4e7de@linux.alibaba.com>
In-Reply-To: <33691ba1-6427-4439-5aa9-792ec8b4e7de@linux.alibaba.com>
To: keyrings@vger.kernel.org

On 2019/8/31 11:10 PM, Jia Zhang wrote:
>> +	       n > 0) {
>> +		ERR(BIO_write(bm, buf, n) < 0, "%s", dest_name);
>> +		left -= n;
>> +	}
>> +	BIO_free(bo);
>> +	ERR(BIO_reset(bm) < 0, "%s", raw_module_name);
>>  
> How about not creating a temporary ~raw~ file?
> 
> You already get the unsigned module size, so you can write it to a new
> mem BIO object as following:
> 
> BIO *bm = BIO_new(BIO_s_mem());
> BIO *bf = BIO_new_file(module_name, "rb");
> 
> while (1) {
> 	int sz = BIO_read(bf, buf, sizeof(buf));
> 	if (sz <= 0)
> 		break;
> 
> 	BIO_write(bm, buf, sz);
> }
> 
> BIO_reset(bm);
> 
> and then reuse the original codes.
> 
> Jia
> 
>>  	if (!raw_sig) {
>>  		/* Read the private key and the X.509 cert the PKCS#7 message
>> @@ -415,10 +435,17 @@ int main(int argc, char **argv)


Great ideas! But there's limitation on the read end of BIO_s_mem, that data can't
be read twice. What have been read will be wiped out immediately by BIO.
So I will try some workaround to it.

Thanks,
Yihao
