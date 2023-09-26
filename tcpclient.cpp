#include "tcpclient.h"

TcpClient::TcpClient(QObject *parent)
    : QObject{parent}
{
    connect(&_socket, &QTcpSocket::connected, this, &TcpClient::onConnected);
    connect(&_socket, &QTcpSocket::errorOccurred, this, &TcpClient::onErrorOccurred);
    connect(&_socket, &QTcpSocket::readyRead, this, &TcpClient::onReadyRead);
}

void TcpClient::conenctToServer(const QString &ip, const QString &port)
{
    _socket.connectToHost(ip, port.toUInt());

}

void TcpClient::onConnected(){

    qInfo() << "Connected to host";

}

void TcpClient::onErrorOccurred(QAbstractSocket::SocketError error){

    qInfo() << "Error" << error;

}

void TcpClient::onReadyRead(){

    const auto message = _socket.readAll();
    emit newMessage(message);
}

void TcpClient::sendMessage(const QString &message){

    _socket.write(message.toUtf8());
    _socket.flush();

}
