//
//  main.cpp
//  TestTimeTound
//
//  Created by MacPro on 2017/12/5.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#include <iostream>
#include <iomanip>
#include <queue>
#include <list>
#include <algorithm>

using namespace std;

class PCB {
public:
    // 线程名
    int pid;
    // 到达时间
    int arrivalTime;
    // 初始到达时间
    int initialServeTime;
    // 需要的时间
    int needTime;
    // 剩余时间
    int leaveTime;
    
    // 默认构造函数
    PCB() {
        
    }
    // 自定义构造函数
    PCB(int pid, int arrivalTime, int initialServeTime) {
        this->pid = pid;
        this->arrivalTime = arrivalTime;
        this->needTime = initialServeTime;
        this->initialServeTime = initialServeTime;
        leaveTime = 0;
    }
    
    bool operator == (const PCB &a)const {
        return pid == a.pid ? true : false;
    }
    
    /** 操作符 < 重载 */
    bool operator < (const PCB &a)const {
        return pid < a.pid;
    }
    
    
};

class RR {
public:
    // 处理队列
    queue<PCB> processQue;
    list<PCB> allNeedList;
    list<PCB> allFinishList;
    static int TIME_SLICE;
    
    // 准备处理, 申请队列资源
    void prepareProcess(int pid,int arriveTime,int needTime);
    // 时间片
    void schedule();
    // 打印完成列表
    void printFinishList();
    // 打印队列
    void printQueue();
    
};

/** RR 的时间片 */
int RR::TIME_SLICE=1;
/** 时间片 */
void RR::schedule() {
    
    int currentTime=0;
    bool isBusy=false;
    PCB currentProcess;
    // 设置队列顺序
    allNeedList.sort();
    while (true) {
        // 遍历 pcb list
        for (list<PCB>::iterator i = allNeedList.begin(); i != allNeedList.end();) {
            
            if(currentTime >= (*i).arrivalTime) { //错误，这里用>=而不是==,进程在中间可能进不来
                processQue.push(*i);   //若进程到达，加入队列
                i = allNeedList.erase(i); //
            } else {
                i++;
            }
        }
        
        //特殊情况处理：当TIME_SLICE不为1时，处理机空闲时，进程要在时间片中间进入
        if (!isBusy && processQue.empty() && !allNeedList.empty() && currentTime < allNeedList.front().arrivalTime) {
            currentTime = allNeedList.front().arrivalTime;
            for (list<PCB>::iterator i = allNeedList.begin(); i != allNeedList.end();) {
                
                if (currentTime >= (*i).arrivalTime) {
                    processQue.push(*i);   //若进程到达，加入队列
                    i=allNeedList.erase(i);
                } else {
                    i++;
                }
            }
        }
        
        //进程完成或者时间片结束，更新服务时间，解除占用
        if (isBusy) {
            if (currentProcess.needTime > TIME_SLICE) {
                currentProcess.needTime -= TIME_SLICE;
                processQue.push(currentProcess);
            } else {
                currentProcess.needTime = 0;//直接出列
                currentProcess.leaveTime = currentTime;
                cout<<"      进程: "<<currentProcess.pid<<"已结束 ";
                cout<<"   周转时间："<<currentTime-currentProcess.arrivalTime;
                cout<<"带权周转时间："<<(currentTime-currentProcess.arrivalTime)/(double)currentProcess.initialServeTime<<endl;
                // 设置放到队尾
                allFinishList.push_back(currentProcess);
            }
            isBusy = false;
        }
        //给队首元素分配处理机
        
        if (!isBusy && !processQue.empty()) {
            currentProcess = processQue.front();
            processQue.pop();
            cout<<"      进程: "<<currentProcess.pid<<"在时刻"<<currentTime<<"开始占用处理机\n";
            isBusy = true;
            
        }
        //如果所需服务时间大于时间片，中断程序
        if (currentProcess.needTime >= TIME_SLICE) {
            currentTime += TIME_SLICE;
            //错误，如果所需服务时间小于时间片，当前进程结束，调度队列里的进程
        } else {
            currentTime += currentProcess.needTime;
        }
        
        //最后所有进程结束，退出
        if (allNeedList.empty() && processQue.empty() && !isBusy)
            break;
        
    }
    
}

void RR::prepareProcess(int pid,int arriveTime,int needTime) {
    PCB newProcess(pid,arriveTime,needTime);
    allNeedList.push_back(newProcess);
}

void RR::printFinishList() {
    allFinishList.sort();
    setiosflags(ios::left);
    cout<<setw(15)<<"进程"<<setw(15)<<"到达时间"<<setw(15)<<"服务时间"<<setw(15)<<"周转时间"<<setw(15)<<"带权周转时间\n";
    for (list<PCB>::iterator i=allFinishList.begin(); i!=allFinishList.end(); i++) {
        cout<<setw(15)<<(*i).pid<<setw(15)<<(*i).arrivalTime<<setw(15)<<(*i).initialServeTime<<setw(15)<<(*i).leaveTime-(*i).arrivalTime<<setw(15)<<((*i).leaveTime-(*i).arrivalTime)/(double)(*i).initialServeTime<<"\n";
    }
}
void RR::printQueue() {
    while (!processQue.empty()) {
        cout<<processQue.front().needTime<<" ";
        processQue.pop();
    }
}




int main(int argc, const char * argv[]) {
    
    RR one;
    one.prepareProcess(1,1,4);
    one.prepareProcess(2,2,3);
    one.prepareProcess(3,3,4);
    one.prepareProcess(4,4,2);
    one.prepareProcess(5,5,4);
    one.prepareProcess(6,6,4);
    one.prepareProcess(7,7,2);
    one.prepareProcess(8,8,4);
    one.TIME_SLICE = 5;
    one.schedule();
    one.printFinishList();
    return 0;
}
