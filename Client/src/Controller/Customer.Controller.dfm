object dmCustomerController: TdmCustomerController
  OldCreateOrder = False
  Height = 150
  Width = 215
  object fdmCustomer: TFDMemTable
    BeforePost = fdmCustomerBeforePost
    BeforeDelete = fdmCustomerBeforeDelete
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 88
    Top = 24
    object fdmCustomerid: TIntegerField
      FieldName = 'id'
    end
    object fdmCustomercode: TStringField
      FieldName = 'code'
    end
    object fdmCustomerdescription: TStringField
      FieldName = 'description'
      Size = 200
    end
    object fdmCustomercity: TStringField
      FieldName = 'city'
      Size = 200
    end
    object fdmCustomernote: TStringField
      FieldName = 'note'
      Size = 200
    end
    object fdmCustomerrating: TIntegerField
      FieldName = 'rating'
    end
  end
end
