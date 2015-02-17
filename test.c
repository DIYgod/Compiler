/* 
* This is a test file
*/

int main(void)
{
	char c = 'a';
	string s = "anotherhome";
	int i = 9;
	double d = 9.7;
	//short sh = 1;
	if(i > 7)
	{
		s[0] = 'b';
		eat(i);
	}
	else
		s[0] = 'c';
	while(i>20||i<10)
	{
		i = 15;
	}
	for(int count = 0; count < 100 ; count++)
	{
		food++;
	}
	switch(i)
	{
		case 1: c = 'b'; break;
		case 2: c = 'c'; break;
		default: c = 'o'; break;
	}
}

int eat(int food)
{
	food--;
	return food;
}
