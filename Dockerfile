# 베이스 이미지 설정
FROM mcr.microsoft.com/windows/servercore:ltsc2019


# Visual Studio Build Tools를 설치하여 C++ 컴파일러를 제공
RUN powershell -Command \
    Invoke-WebRequest -Uri https://aka.ms/vs/17/release/vs_buildtools.exe -OutFile vs_buildtools.exe ; \
    Start-Process vs_buildtools.exe -ArgumentList '--quiet --wait --norestart --nocache --installPath C:\BuildTools --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended' -NoNewWindow -Wait ; \
    Remove-Item -Force vs_buildtools.exe

# hello.cpp 파일을 컨테이너로 복사
COPY hello.cpp C:/hello.cpp

# C++ 프로그램을 컴파일
RUN "C:\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x64 && cl C:/hello.cpp /Fe:C:/hello.exe

# 프로그램 실행
CMD ["C:\\hello.exe"]    