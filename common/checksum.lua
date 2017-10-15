--[[uint32_t fletcher32( uint16_t const *data, size_t words )
{
        uint32_t sum1 = 0xffff, sum2 = 0xffff;
        size_t tlen;
 
        while (words) {
                tlen = ((words >= 359) ? 359 : words);
                words -= tlen;
                do {
                        sum2 += sum1 += *data++;
                        tlen--;
                } while (tlen);
                sum1 = (sum1 & 0xffff) + (sum1 >> 16);
                sum2 = (sum2 & 0xffff) + (sum2 >> 16);
        }
        /* Second reduction step to reduce sums to 16 bits */
        sum1 = (sum1 & 0xffff) + (sum1 >> 16);
        sum2 = (sum2 & 0xffff) + (sum2 >> 16);
        return (sum2 << 16) | sum1;
}]]--

Checksum = {}

function Checksum.fletcher32(data)
	dat = data
	local stringpointer = 1
	local lenlen = string.len(data)
	local lenlensup = math.ceil(lenlen / 16) * 16
	for i=1,(lenlensup - lenlen) do
		dat = dat .. 'A'
	end
	local count = lenlensup
	sum1 = 65535
	sum2 = 65535
	local clen
	while count > 0 do
		if count >= 359 then
			clen = 359
		else
			clen = count
		end
		count = count - clen
		repeat
			sum1 = sum1 + string.byte(string.sub(dat,stringpointer, stringpointer))
			stringpointer = stringpointer + 1
			sum2 = sum2 + sum1
			clen = clen - 1
		until clen <= 0
		sum1 = (sum1 & 65535) + (sum1 >> 16)
		sum2 = (sum2 & 65535) + (sum2 >> 16)
	end
	sum1 = (sum1 & 65535) + (sum1 >> 16)
	sum2 = (sum2 & 65535) + (sum2 >> 16)
	return (sum2 << 16) | sum1
end