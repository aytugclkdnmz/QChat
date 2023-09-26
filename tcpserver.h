#ifndef TCPSERVER_H
#define TCPSERVER_H

#include <QObject>
#include <QTcpServer>
#include <QTcpSocket>
#include <QHash>
class TcpServer : public QObject
{
    Q_OBJECT
public:
    explicit TcpServer(QObject *parent = nullptr);

signals:
    void newMessage(const QByteArray &message);
public slots:
    void sendMessage(const QString &message);

private slots:
    void onNewConnection();
    void onReadyRead();
    void onNewMessage(const QByteArray &ba);
    void onDisconnected();

private:
    QString getClientKey(const QTcpSocket *client) const{

        return client->peerAddress().toString().append(":").append(QString::number(client->peerPort()));
    }

private:
    QTcpServer _server;
    QHash<QString, QTcpSocket*> _clients;


};

#endif // TCPSERVER_H
