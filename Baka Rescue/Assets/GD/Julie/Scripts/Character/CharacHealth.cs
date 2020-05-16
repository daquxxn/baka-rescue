using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CharacHealth : MonoBehaviour
{

    [SerializeField] private int _maxHealth = 100;
    private int _currentHealth;

    [SerializeField] private Healthbar _healthBar = null;

    

    public int CurrentHealth
    {
        get
        { return _currentHealth; }
        set
        { _currentHealth = value; }
    }

    public int MaxHealth
    {
        get
        { return _maxHealth; }
    }

    // Start is called before the first frame update
    void Start()
    {
        _currentHealth = _maxHealth;
        _healthBar.SetMaxHealth(_maxHealth);
    }

    
    public void TakeDamage(int damage)
    {
        _currentHealth -= damage;
        _healthBar.SetHealth(_currentHealth);
    }
    
    public void GetLifeBack(int heal)
    {
        _currentHealth += heal;
        _healthBar.SetHealth(_currentHealth);
    }
}
