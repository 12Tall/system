void myprint(char* msg,int len);  // declare asm function

int choose(int a, int b){  // define c-style function
        if(a>=b){
                myprint("the 1st one\n",13);  // call asm function
        }
        else{
                myprint("the 2nd one\n",13);
        }
        return 0;
}
