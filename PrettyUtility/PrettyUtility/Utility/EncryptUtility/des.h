#ifndef Des_H
#define Des_H

typedef bool    (*PSubKey)[16][48];

class Des
{
public:
	Des();
	~Des();

	char* m_pOut;

	enum {ENCRYPT,DECRYPT};

	bool Encrypt(char** out, int* outLen, char* in, int inLen, const unsigned char* key);

	bool Run3Des(unsigned char *Out,unsigned char *In,long datalen,const unsigned char *Key,int keylen,bool Type = ENCRYPT);

	void destory();

private:

	static void DES(unsigned char Out[8],unsigned char In[8], const PSubKey pSubKey, bool Type);//标准DES加/解密

	static void SetKey(const unsigned char* Key, int len);// 设置密钥

	static void SetSubKey(PSubKey pSubKey, const unsigned char Key[8]);// 设置子密钥

	static void F_func(bool In[32], const bool Ki[48]);// f 函数

	static void S_func(bool Out[32], const bool In[48]);// S 盒代替

	static void Transform(bool *Out, bool *In, const unsigned char *Table, int len);// 变换

	static void Xor(bool *InA, const bool *InB, int len);// 异或

	static void RotateL(bool *In, int len, int loop);// 循环左移

	static void ByteToBit(bool *Out, const unsigned char *In, int bits);// 字节组转换成位组

	static void BitToByte(unsigned char *Out, const bool *In, int bits);// 位组转换成字节组

	static void printArray(unsigned char* array, int len);

	static void printBool(bool* array, int len);
};

#endif
