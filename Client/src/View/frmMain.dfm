object frmViewCustomer: TfrmViewCustomer
  Left = 0
  Top = 0
  Caption = 'View Customer'
  ClientHeight = 290
  ClientWidth = 471
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 471
    Height = 290
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = -8
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 471
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitLeft = 144
      ExplicitTop = 128
      ExplicitWidth = 185
      object btnGetAll: TButton
        Left = 0
        Top = 0
        Width = 75
        Height = 41
        Action = actGetAll
        Align = alLeft
        TabOrder = 0
        ExplicitLeft = 40
        ExplicitTop = 16
        ExplicitHeight = 25
      end
      object dbnCustomer: TDBNavigator
        Left = 81
        Top = 0
        Width = 390
        Height = 41
        DataSource = dsCustomer
        Align = alRight
        TabOrder = 1
      end
    end
    object pnlCenter: TPanel
      Left = 0
      Top = 41
      Width = 471
      Height = 249
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitLeft = 120
      ExplicitTop = 200
      ExplicitWidth = 185
      ExplicitHeight = 41
      object dbgCustomer: TDBGrid
        Left = 0
        Top = 0
        Width = 471
        Height = 249
        Align = alClient
        DataSource = dsCustomer
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
  end
  object actManageCustomers: TActionManager
    Left = 344
    Top = 8
    StyleName = 'Platform Default'
    object actGetAll: TAction
      Caption = 'Get All'
      OnExecute = actGetAllExecute
    end
  end
  object dsCustomer: TDataSource
    DataSet = dmCustomerController.fdmCustomer
    Left = 232
    Top = 8
  end
end
